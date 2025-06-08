-- Propiedades
create table properties (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Unidades
create table units (
  id uuid primary key default gen_random_uuid(),
  property_id uuid references properties(id),
  name text not null,
  coefficient numeric not null,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Usuarios
create table users (
  id uuid primary key default gen_random_uuid(),
  clerk_id text unique not null,
  role text not null,
  unit_id uuid references units(id),
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Asambleas
create table assemblies (
  id uuid primary key default gen_random_uuid(),
  property_id uuid references properties(id),
  scheduled_at timestamp with time zone not null,
  agenda text,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Asistencia
create table attendance (
  id uuid primary key default gen_random_uuid(),
  assembly_id uuid references assemblies(id),
  user_id uuid references users(id),
  joined_at timestamp with time zone,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Mociones
create table motions (
  id uuid primary key default gen_random_uuid(),
  assembly_id uuid references assemblies(id),
  title text not null,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Votos
create table votes (
  id uuid primary key default gen_random_uuid(),
  motion_id uuid references motions(id),
  user_id uuid references users(id),
  value text check (value in ('si','no','abstencion')),
  coefficient numeric not null,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Paquetes
create table parcels (
  id uuid primary key default gen_random_uuid(),
  unit_id uuid references units(id),
  description text,
  received_at timestamp with time zone default now(),
  confirmed boolean default false,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Visitantes
create table visitors (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  type text check (type in ('social','entrega')),
  document text,
  unit_id uuid references units(id),
  parcel_id uuid references parcels(id),
  arrived_at timestamp with time zone default now(),
  departed_at timestamp with time zone,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Amenidades
create table amenities (
  id uuid primary key default gen_random_uuid(),
  property_id uuid references properties(id),
  name text not null,
  capacity integer,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Reservas
create table reservations (
  id uuid primary key default gen_random_uuid(),
  amenity_id uuid references amenities(id),
  user_id uuid references users(id),
  reserved_at timestamp with time zone not null,
  status text default 'active',
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Servicios
create table services (
  id uuid primary key default gen_random_uuid(),
  category text,
  name text,
  price numeric,
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- Ordenes de Servicio
create table service_orders (
  id uuid primary key default gen_random_uuid(),
  service_id uuid references services(id),
  user_id uuid references users(id),
  requested_at timestamp with time zone default now(),
  _created_at timestamp with time zone default now(),
  _updated_at timestamp with time zone default now()
);

-- RLS
alter table properties enable row level security;
alter table units enable row level security;
alter table users enable row level security;
alter table assemblies enable row level security;
alter table attendance enable row level security;
alter table motions enable row level security;
alter table votes enable row level security;
alter table parcels enable row level security;
alter table visitors enable row level security;
alter table amenities enable row level security;
alter table reservations enable row level security;
alter table services enable row level security;
alter table service_orders enable row level security;
