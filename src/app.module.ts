import { Module } from '@nestjs/common';
import { ExcelModule } from './excel/excel.module';
import { PrismaModule } from './prisma/prisma.module';
import { ExcelService } from './excel/excel.service';
import { PrismaService } from './prisma/prisma.service';
import { ExcelController } from './excel/excel.controller';

@Module({
  imports: [ExcelModule, PrismaModule],
  controllers: [ExcelController],
  providers: [ExcelService,PrismaService],
})
export class AppModule {}
