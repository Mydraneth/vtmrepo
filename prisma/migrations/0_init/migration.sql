-- CreateEnum
CREATE TYPE "Entity" AS ENUM ('Vampire', 'Ghoul', 'Mortal', 'Hunter');

-- CreateEnum
CREATE TYPE "category" AS ENUM ('Physical', 'Social', 'Mental');

-- CreateEnum
CREATE TYPE "forWhom" AS ENUM ('Ghoul', 'Vampire', 'All');

-- CreateEnum
CREATE TYPE "type" AS ENUM ('Merit', 'Flaw', 'Loresheet', 'Background');

-- CreateTable
CREATE TABLE "advantages" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "parent_name" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" "type" NOT NULL,
    "level" INTEGER NOT NULL,
    "for" "forWhom" NOT NULL,
    "clan_req" UUID,
    "sect_req" UUID,

    CONSTRAINT "advantages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "alchemy_powers" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "description" TEXT,
    "ingridients" TEXT,
    "activation" TEXT,
    "dice_pool" TEXT,
    "system" TEXT,
    "duration" TEXT,
    "level" INTEGER,

    CONSTRAINT "alchemy_powers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "attributes" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "category" "category" NOT NULL,

    CONSTRAINT "attributes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "blood_potency" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "level" INTEGER NOT NULL,
    "description" TEXT,
    "blood_surge" TEXT,
    "damage_mend" TEXT,
    "power_bonus" TEXT,
    "rc_reroll" TEXT,
    "bane_severity" INTEGER,
    "feeding_penalty" TEXT,

    CONSTRAINT "blood_potency_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "char_groups" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" UUID NOT NULL,
    "parent_id" UUID,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "char_groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_advantages" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "advantage_id" UUID NOT NULL,

    CONSTRAINT "character_advantages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_alchemy_powers" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "alchemy_power_id" UUID NOT NULL,

    CONSTRAINT "character_alchemy_powers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_attributes" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "attribute_id" UUID NOT NULL,
    "level" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "character_attributes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_bloodpotencies" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "blood_potency_level" UUID,
    "blood_surge" TEXT,
    "bane_severity" INTEGER DEFAULT 0,
    "power_bonus" TEXT,
    "feeding_penalty" TEXT,
    "mend_amount" INTEGER,
    "rc_reroll" TEXT,
    "clane_bane" UUID,
    "clan_compulsion" UUID,

    CONSTRAINT "character_bloodpotencies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_discipline_powers" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "discipline_power_id" UUID NOT NULL,

    CONSTRAINT "character_discipline_powers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_disciplines" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "discipline_id" UUID NOT NULL,

    CONSTRAINT "character_disciplines_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_healths" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "max_health" INTEGER NOT NULL,
    "current_aggravated" INTEGER NOT NULL DEFAULT 0,
    "current_superficial" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "character_healths_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_humanity" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "level" INTEGER NOT NULL DEFAULT 0,
    "stain_count" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "character_humanity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_profile" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "description" TEXT NOT NULL,
    "birthday" TIMESTAMPTZ(6) NOT NULL,
    "notes" TEXT,
    "age" INTEGER NOT NULL,
    "embraced_at" TIMESTAMPTZ(6) NOT NULL,
    "apparent_age" INTEGER NOT NULL,
    "concept" TEXT,

    CONSTRAINT "character_profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_rituals" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "ritual_id" UUID NOT NULL,

    CONSTRAINT "character_rituals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_skills" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "skill_id" UUID NOT NULL,
    "level" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "character_skills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_specialties" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "skill_id" UUID NOT NULL,
    "specialty_name" TEXT NOT NULL,

    CONSTRAINT "character_specialties_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_willpowers" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "char_id" UUID NOT NULL,
    "max_willpower" INTEGER NOT NULL,
    "current_aggravated" INTEGER NOT NULL DEFAULT 0,
    "current_superficial" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "character_willpowers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "characters" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "clan_id" UUID,
    "clan_bane" UUID,
    "clan_compulsion" UUID,
    "sect_id" UUID,
    "player" TEXT NOT NULL,
    "predator_type" UUID NOT NULL,
    "generation" INTEGER NOT NULL,
    "chronicle_id" UUID,
    "custom_chronicle" TEXT,
    "ambition" TEXT NOT NULL,
    "desire" TEXT NOT NULL,
    "sire" TEXT NOT NULL,
    "total_experience" INTEGER NOT NULL DEFAULT 0,
    "chronicle_tenets" TEXT NOT NULL,
    "group_id" UUID NOT NULL,
    "type" "Entity" NOT NULL DEFAULT 'Vampire',

    CONSTRAINT "characters_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chronicles" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "chronicles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clan_banes" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "clan_id" UUID NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "clan_banes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clan_compulsions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "clan_id" UUID NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "clan_compulsions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clans" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "clans_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "discipline_powers" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "discipline_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "level" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "dice_pool" TEXT NOT NULL,
    "cost" TEXT NOT NULL,
    "prerequisites" TEXT NOT NULL,
    "amalgam" TEXT NOT NULL,
    "system" TEXT NOT NULL,
    "duration" TEXT NOT NULL,

    CONSTRAINT "discipline_powers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "disciplines" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "nicknames" TEXT NOT NULL,
    "characteristics" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "masquerade_threat" TEXT NOT NULL,
    "blood_resonance" TEXT NOT NULL,

    CONSTRAINT "disciplines_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exp_logs" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" UUID NOT NULL,
    "char_id" UUID NOT NULL,
    "section" TEXT,
    "name" TEXT,
    "prev_level" INTEGER,
    "new_level" INTEGER,
    "expanditure" INTEGER,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "exp_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "humanity" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "description" TEXT NOT NULL,
    "level" INTEGER NOT NULL,

    CONSTRAINT "humanity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "predator_types" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "dice_pool" TEXT NOT NULL,
    "benefits" TEXT NOT NULL,

    CONSTRAINT "predator_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rituals" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "ingridients" TEXT NOT NULL,
    "process" TEXT NOT NULL,
    "system" TEXT NOT NULL,
    "level" INTEGER NOT NULL,

    CONSTRAINT "rituals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sects" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "sects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "skills" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "skills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "clerk_user_id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "image_url" TEXT,
    "deleted_at" TIMESTAMPTZ(6),
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_clerk_user_id_unique" ON "users"("clerk_user_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_unique" ON "users"("email");

-- AddForeignKey
ALTER TABLE "advantages" ADD CONSTRAINT "advantages_clan_req_clans_id_fk" FOREIGN KEY ("clan_req") REFERENCES "clans"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "advantages" ADD CONSTRAINT "advantages_sect_req_sects_id_fk" FOREIGN KEY ("sect_req") REFERENCES "sects"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "char_groups" ADD CONSTRAINT "char_groups_parent_id_char_groups_id_fk" FOREIGN KEY ("parent_id") REFERENCES "char_groups"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "char_groups" ADD CONSTRAINT "char_groups_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_advantages" ADD CONSTRAINT "character_advantages_advantage_id_advantages_id_fk" FOREIGN KEY ("advantage_id") REFERENCES "advantages"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_advantages" ADD CONSTRAINT "character_advantages_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_alchemy_powers" ADD CONSTRAINT "character_alchemy_powers_alchemy_power_id_alchemy_powers_id_fk" FOREIGN KEY ("alchemy_power_id") REFERENCES "alchemy_powers"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_alchemy_powers" ADD CONSTRAINT "character_alchemy_powers_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_attributes" ADD CONSTRAINT "character_attributes_attribute_id_attributes_id_fk" FOREIGN KEY ("attribute_id") REFERENCES "attributes"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_attributes" ADD CONSTRAINT "character_attributes_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_bloodpotencies" ADD CONSTRAINT "character_bloodpotencies_blood_potency_level_blood_potency_id_f" FOREIGN KEY ("blood_potency_level") REFERENCES "blood_potency"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_bloodpotencies" ADD CONSTRAINT "character_bloodpotencies_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_bloodpotencies" ADD CONSTRAINT "character_bloodpotencies_clan_compulsion_clan_compulsions_id_fk" FOREIGN KEY ("clan_compulsion") REFERENCES "clan_compulsions"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_bloodpotencies" ADD CONSTRAINT "character_bloodpotencies_clane_bane_clan_banes_id_fk" FOREIGN KEY ("clane_bane") REFERENCES "clan_banes"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_discipline_powers" ADD CONSTRAINT "character_discipline_powers_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_discipline_powers" ADD CONSTRAINT "character_discipline_powers_discipline_power_id_discipline_powe" FOREIGN KEY ("discipline_power_id") REFERENCES "discipline_powers"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_disciplines" ADD CONSTRAINT "character_disciplines_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_disciplines" ADD CONSTRAINT "character_disciplines_discipline_id_disciplines_id_fk" FOREIGN KEY ("discipline_id") REFERENCES "disciplines"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_healths" ADD CONSTRAINT "character_healths_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_humanity" ADD CONSTRAINT "character_humanity_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_profile" ADD CONSTRAINT "character_profile_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_rituals" ADD CONSTRAINT "character_rituals_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_rituals" ADD CONSTRAINT "character_rituals_ritual_id_rituals_id_fk" FOREIGN KEY ("ritual_id") REFERENCES "rituals"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_skills" ADD CONSTRAINT "character_skills_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_skills" ADD CONSTRAINT "character_skills_skill_id_skills_id_fk" FOREIGN KEY ("skill_id") REFERENCES "skills"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_specialties" ADD CONSTRAINT "character_specialties_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_specialties" ADD CONSTRAINT "character_specialties_skill_id_skills_id_fk" FOREIGN KEY ("skill_id") REFERENCES "skills"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "character_willpowers" ADD CONSTRAINT "character_willpowers_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "characters" ADD CONSTRAINT "characters_chronicle_id_chronicles_id_fk" FOREIGN KEY ("chronicle_id") REFERENCES "chronicles"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "characters" ADD CONSTRAINT "characters_clan_bane_clan_banes_id_fk" FOREIGN KEY ("clan_bane") REFERENCES "clan_banes"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "characters" ADD CONSTRAINT "characters_clan_compulsion_clan_compulsions_id_fk" FOREIGN KEY ("clan_compulsion") REFERENCES "clan_compulsions"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "characters" ADD CONSTRAINT "characters_clan_id_clans_id_fk" FOREIGN KEY ("clan_id") REFERENCES "clans"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "characters" ADD CONSTRAINT "characters_group_id_char_groups_id_fk" FOREIGN KEY ("group_id") REFERENCES "char_groups"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "characters" ADD CONSTRAINT "characters_predator_type_predator_types_id_fk" FOREIGN KEY ("predator_type") REFERENCES "predator_types"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "characters" ADD CONSTRAINT "characters_sect_id_sects_id_fk" FOREIGN KEY ("sect_id") REFERENCES "sects"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "characters" ADD CONSTRAINT "characters_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "chronicles" ADD CONSTRAINT "chronicles_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "clan_banes" ADD CONSTRAINT "clan_banes_clan_id_clans_id_fk" FOREIGN KEY ("clan_id") REFERENCES "clans"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "clan_compulsions" ADD CONSTRAINT "clan_compulsions_clan_id_clans_id_fk" FOREIGN KEY ("clan_id") REFERENCES "clans"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "discipline_powers" ADD CONSTRAINT "discipline_powers_discipline_id_disciplines_id_fk" FOREIGN KEY ("discipline_id") REFERENCES "disciplines"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "exp_logs" ADD CONSTRAINT "exp_logs_char_id_characters_id_fk" FOREIGN KEY ("char_id") REFERENCES "characters"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "exp_logs" ADD CONSTRAINT "exp_logs_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

