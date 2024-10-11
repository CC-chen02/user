import { Module } from '@nestjs/common';
import { ExcelService } from './excel.service';
import { ExcelController } from './excel.controller';
import { PrismaService } from '../prisma/prisma.service';

@Module({
  controllers: [ExcelController],
  providers: [ExcelService, PrismaService],
})
export class ExcelModule { }
