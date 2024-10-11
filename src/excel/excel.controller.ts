import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors } from '@nestjs/common';
import { ExcelService } from './excel.service';
import { UploadedFile } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import path, { join } from 'path';

@Controller('excel')
export class ExcelController {
  constructor(private readonly excelService: ExcelService) { }

  @Post('upload')
  @UseInterceptors(FileInterceptor('file', { dest: './uploads' }))
  async importFromExcel(
    @UploadedFile() file: Express.Multer.File,
  ) {
    console.log(process.cwd());
    const filepath = join(
      process.cwd(), 'uploads',
      file.filename,
    );

    const result = await this.excelService.importFromExcel(
      filepath
    );
    return result;
  }
}