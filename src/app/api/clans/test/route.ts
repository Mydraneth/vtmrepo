import { prisma } from '../../../../../lib/prisma';

export async function GET() {
  const clans = await prisma.clans.findMany();
  return Response.json(clans);
}
