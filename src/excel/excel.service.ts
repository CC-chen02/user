import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import * as ExcelJS from 'exceljs';

@Injectable()
export class ExcelService {
  constructor(private prisma: PrismaService) { }

  async importFromExcel(filepath: string): Promise<any> {
    const workbook = new ExcelJS.Workbook();
    await workbook.xlsx.readFile(filepath);
    const residentData: {
      index: string;
      name: string;
      phone: string;
      address: string;
    }[] = [];

    workbook.eachSheet(async (worksheet) => {
      console.log(worksheet.name);
      await worksheet.eachRow(async (row) => {
        if (row.number !== 1) {
          const index = row.getCell(1).value.toString();
          const name = row.getCell(2).value.toString();
          const phone = row.getCell(3).value;
          const address = row.getCell(4).value?.toString();

          if (phone && !residentData.find(record => record.phone === phone.toString())) {
            residentData.push({
              index,
              name,
              phone: phone.toString(),
              address,
            });
          }
        }
      });
    });

    for (const data of residentData) {
      const { name, phone } = data
      await this.prisma.residentHousehold.create({
        data: {
          Resident: {
            connectOrCreate: {
              where: { phone },
              create: {
                name,
                User: {
                  connectOrCreate: {
                    where: {
                      phone,
                    },
                    create: {
                      name,
                      phone,
                    }
                  },
                },
              }

            },
          },
          Household: {
            connect: {
              // id: 'cm21au6xh0000r1hccabuulgz',//正式环境
              id: '123467889',//练习
            },
          },
          isFeePayer: true,
          role: 'Owner',
        },
      });
    }
    return residentData;
  }
}