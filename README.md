# Quorum Suite

Quorum Suite es una plataforma para la administraci\u00f3n de asambleas virtuales, control de visitantes, manejo de paquetes, reservas de amenidades y un marketplace de servicios dom\u00e9sticos.

## Desarrollo local

1. Clona el repositorio y copia `.env.local.example` a `.env.local` configurando las variables de Clerk, Supabase, Mailgun, OneSignal y Twilio.
2. Levanta los servicios locales:

```bash
docker-compose up -d
```

3. Aplica la base de datos:

```bash
supabase db push
```

4. Inicia la aplicaci\u00f3n:

```bash
npm install
npm run dev
```

La aplicaci\u00f3n se despliega a Vercel utilizando las mismas variables de entorno.
