create table
    public.delegations (
        uuid uuid not null default gen_random_uuid (),
        delegated_to_ref uuid not null,
        delegated_by_ref uuid not null,
        business_model_refs uuid[] null,
        category_refs uuid[] null,
        subcategory_refs uuid[] null,
        country_refs uuid[] null,
        state_refs uuid[] null,
        annual_sale_ranges jsonb[] null,
        employee_count_ranges jsonb[] null,
        added_at timestamp with time zone not null default now(),
        added_by_ref uuid not null default auth.uid (),
        updated_at timestamp with time zone not null default now(),
        updated_by_ref uuid not null default auth.uid (),
        deleted_at timestamp with time zone null,
        deleted_by_ref uuid null,
        constraint delegations_pkey primary key (uuid),
        constraint delegations_delegated_by_ref_fkey foreign key (delegated_by_ref) references auth.users (id) on update cascade,
        constraint delegations_delegated_to_ref_fkey foreign key (delegated_to_ref) references auth.users (id) on update cascade,
        constraint delegations_added_by_ref_fkey foreign key (added_by_ref) references auth.users (id) on update cascade,
        constraint delegations_deleted_by_ref_fkey foreign key (deleted_by_ref) references auth.users (id) on update cascade,
        constraint delegations_updated_by_ref_fkey foreign key (updated_by_ref) references auth.users (id) on update cascade
    ) tablespace pg_default;