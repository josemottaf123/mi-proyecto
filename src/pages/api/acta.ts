import { NextApiRequest, NextApiResponse } from 'next';
import { pdf, Document, Page, Text } from '@react-pdf/renderer';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { sociedad = 'SOCIEDAD', fecha = new Date().toISOString() } = req.query;

  const doc = (
    <Document>
      <Page>
        <Text style={{ textAlign: 'center', textTransform: 'uppercase' }}>
          ACTA DE UNA REUNION EXTRAORDINARIA DE LA JUNTA DIRECTIVA DE {sociedad}
        </Text>
        <Text>
          Siendo las dos de la tarde (2:00 p.m.), en la Ciudad de Panamá, República de Panamá, del día {fecha}, tuvo lugar mediante conferencia telefónica...
        </Text>
      </Page>
    </Document>
  );

  const pdfBuffer = await pdf(doc).toBuffer();
  res.setHeader('Content-Type', 'application/pdf');
  res.send(pdfBuffer);
}
