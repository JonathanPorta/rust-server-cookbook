import math
import ServerConsole
import BasePlayer
import System
import Rust
import StringPool
import UnityEngine.Random as random
from UnityEngine import Vector3

class deathnotes:

    # ==========================================================================
    # <>> PLUGIN SPECIEFIC
    # ==========================================================================
    def __init__(self):

        self.Title = 'Death Notes'
        self.Author = 'SkinN'
        self.Version = V(2, 2, 3)
        self.HasConfig = True
        self.ResourceId = 819

        self.latest_cfg = 2.4

    # --------------------------------------------------------------------------
    def Init(self):

        # UPDATE CONFIGURATION
        if self.Config['CONFIG_VERSION'] < self.latest_cfg: self.UpdateConfig()

        # PLUGIN SPECIEFIC
        if self.Config['SETTINGS']['PREFIX']:
            self.prefix = '<color=%s>%s</color>' % (self.Config['COLORS']['PREFIX COLOR'], self.Config['SETTINGS']['PREFIX'])
        else:
            self.prefix = None

        self.metabolism = ('DROWNED','HEAT','COLD','THIRST','POISON','HUNGER','RADIATION','BLEEDING','FALL')
        self.line = '-' * 50

        # COMMANDS
        #command.AddChatCommand('debug', self.Plugin, 'debug_CMD')

    # ==========================================================================
    # <>> CONFIGURATION
    # ==========================================================================
    def LoadDefaultConfig(self):

        # CFG VERSION
        self.Config['CONFIG_VERSION'] = self.latest_cfg

        # PLUGIN SETTINGS
        self.Config['SETTINGS'] = {}
        self.Config['SETTINGS']['PREFIX'] = 'DEATH☠NOTES'
        self.Config['SETTINGS']['BROADCAST TO CONSOLE'] = True
        self.Config['SETTINGS']['DISPLAY SUICIDE DEATH'] = True
        self.Config['SETTINGS']['DISPLAY METABOLISM DEATH'] = True
        self.Config['SETTINGS']['DISPLAY EXPLOSION DEATH'] = True
        self.Config['SETTINGS']['DISPLAY TRAP DEATH'] = True
        self.Config['SETTINGS']['DISPLAY ANIMAL DEATH'] = True
        self.Config['SETTINGS']['DISPLAY PLAYER KILLS'] = True
        self.Config['SETTINGS']['DISPLAY ANIMAL KILLS'] = True
        self.Config['SETTINGS']['DISPLAY MESSAGES IN RADIUS'] = False
        self.Config['SETTINGS']['MESSAGES RADIUS'] = 200.00

        # CHAT COLORS
        self.Config['COLORS'] = {}
        self.Config['COLORS']['MESSAGE COLOR'] = '#FFFFFF'
        self.Config['COLORS']['PREFIX COLOR'] = '#FF0000'
        self.Config['COLORS']['ANIMAL COLOR'] = '#00FF00'
        self.Config['COLORS']['BODYPART COLOR'] = '#00FF00'
        self.Config['COLORS']['WEAPON COLOR'] = '#00FF00'
        self.Config['COLORS']['VICTIM COLOR'] = '#00FF00'
        self.Config['COLORS']['ATTACKER COLOR'] = '#00FF00'
        self.Config['COLORS']['DISTANCE COLOR'] = '#00FF00'

        # DEATH MESSAGES
        self.Config['MESSAGES'] = {}
        self.Config['MESSAGES']['RADIATION'] = ('{victim} died from radiation.','{victim} did not know that radiation kills.')
        self.Config['MESSAGES']['HUNGER'] = ('{victim} starved to death.','{victim} was a bad hunter, and died of hunger.')
        self.Config['MESSAGES']['THIRST'] = ('{victim} died of thirst.','Dehydration has killed {victim}, what a bitch!')
        self.Config['MESSAGES']['DROWNED'] = ('{victim} drowned.','{victim} thought he could swim, but guess not.')
        self.Config['MESSAGES']['COLD'] = ('{victim} froze to death.','{victim} is an ice cold dead man.')
        self.Config['MESSAGES']['HEAT'] = ('{victim} burned to death.','{victim} turned into a human torch.')
        self.Config['MESSAGES']['FALL'] = ('{victim} died from a big fall.','{victim} believed he could fly, he believed he could touch the sky!')
        self.Config['MESSAGES']['BLEEDING'] = ('{victim} bled to death.','{victim} emptied in blood.')
        self.Config['MESSAGES']['EXPLOSION'] = ('{victim} blown up by C4.','{victim} exploded.')
        self.Config['MESSAGES']['POISON'] = ('{victim} died poisoned.','{victim} eat the wrong meat and died poisoned.')
        self.Config['MESSAGES']['SUICIDE'] = ('{victim} committed suicide.','{victim} has put an end to his life.')
        self.Config['MESSAGES']['TRAP'] = ('{victim} stepped on a snap trap.','{victim} did not watch his steps, died on a trap.')
        self.Config['MESSAGES']['STAB'] = ('{attacker} stabbed {victim} to death. (With {weapon}, in the {bodypart})','{attacker} stabbed a {weapon} in {victim}\'s {bodypart}.')
        self.Config['MESSAGES']['STAB SLEEP'] = ('{attacker} stabbed {victim} to death, while sleeping. (With {weapon}, in the {bodypart})','{attacker} stabbed {victim}, while sleeping. You sneaky little bastard.')
        self.Config['MESSAGES']['SLASH'] = ('{attacker} slashed {victim} into pieces. (With {weapon}, in the {bodypart})','{attacker} has sliced {victim} into a million little pieces.')
        self.Config['MESSAGES']['SLASH SLEEP'] = ('{attacker} slashed {victim} into pieces, while sleeping. (With {weapon}, in the {bodypart})','{attacker} killed {victim} with a {weapon}, while sleeping.')
        self.Config['MESSAGES']['BLUNT'] = ('{attacker} killed {victim}. (With {weapon}, in the {bodypart})','{attacker} made {victim} die of a {weapon} trauma.')
        self.Config['MESSAGES']['BLUNT SLEEP'] = ('{attacker} killed {victim}, while sleeping. (With {weapon}, in the {bodypart})','{attacker} killed {victim} with a {weapon}, while sleeping.')
        self.Config['MESSAGES']['BULLET'] = ('{attacker} killed {victim}. (In the {bodypart} with {weapon}, from {distance}m)','{attacker} made {victim} eat some bullets with a {weapon}.')
        self.Config['MESSAGES']['BULLET SLEEP'] = ('{attacker} killed {victim}, while sleeping. (In the {bodypart} with {weapon}, from {distance}m)','{attacker} killed {victim} with a {weapon}, while sleeping.')
        self.Config['MESSAGES']['ARROW'] = ('{attacker} killed {victim} with an arrow on the {bodypart} from {distance}m','{victim} took an arrow to the knee, and died anyway. (Distance: {distance})')
        self.Config['MESSAGES']['ARROW SLEEP'] = ('{attacker} killed {victim} with an arrow on the {bodypart}, while {victim} was asleep.','{attacker} killed {victim} with a {weapon}, while sleeping.')
        self.Config['MESSAGES']['ANIMAL KILL'] = ('{victim} killed by a {animal}.','{victim} wasn\'t fast enough and a {animal} caught him.')
        self.Config['MESSAGES']['ANIMAL KILL SLEEP'] = ('{victim} killed by a {animal}, while sleeping.','{animal} caught {victim}, while sleeping.')
        self.Config['MESSAGES']['ANIMAL DEATH'] = ('{attacker} killed a {animal}. (In the {bodypart} with {weapon}, from {distance}m)')

        # ENTITY NAMES
        self.Config['WEAPONS'] = {}
        self.Config['WEAPONS']['SALVAGED HAMMER'] = 'Salvaged Hammer'
        self.Config['WEAPONS']['SALVAGED ICEPICK'] = 'Salvaged Icepick'
        self.Config['WEAPONS']['HATCHET STONE'] = 'Stone Hatchet'
        self.Config['WEAPONS']['BONEKNIFE'] = 'Bone Knife'
        self.Config['WEAPONS']['ROCK'] = 'Rock'
        self.Config['WEAPONS']['TORCH'] = 'Torch'
        self.Config['WEAPONS']['WOODEN SPEAR'] = 'Wooden Spear'
        self.Config['WEAPONS']['STONE SPEAR'] = 'Stone Spear'
        self.Config['WEAPONS']['HATCHET'] = 'Hatchet'
        self.Config['WEAPONS']['PICKAXE'] = 'Pickaxe'
        self.Config['WEAPONS']['SALVAGED AXE'] = 'Salvaged Axe'
        self.Config['WEAPONS']['HUNTING'] = 'Hunting Bow'
        self.Config['WEAPONS']['REVOLVER'] = 'Revolver'
        self.Config['WEAPONS']['BOLT'] = 'Bolt Rifle'
        self.Config['WEAPONS']['THOMPSON'] = 'Thompson'
        self.Config['WEAPONS']['AK47U'] = 'AK47U'
        self.Config['WEAPONS']['EOKA'] = 'Eoka Pistol'
        self.Config['WEAPONS']['SAWNOFFSHOTGUN'] = 'Sawn-off Shotgun'
        self.Config['WEAPONS']['WATERPIPE'] = 'Waterpipe Shotgun'

        # ANIMALS
        self.Config['ANIMALS'] = {}
        self.Config['ANIMALS']['BEAR'] = 'Bear'
        self.Config['ANIMALS']['STAG'] = 'Deer'
        self.Config['ANIMALS']['WOLF'] = 'Wolf'
        self.Config['ANIMALS']['CHICKEN'] = 'Chicken'
        self.Config['ANIMALS']['BOAR'] = 'Boar'

        # BODYPARTS
        self.Config['BODY PARTS'] = {}
        self.Config['BODY PARTS']['HEAD'] = 'Head'
        self.Config['BODY PARTS']['SPINE'] = 'Spine'
        self.Config['BODY PARTS']['NECK'] = 'Neck'
        self.Config['BODY PARTS']['PELVIS'] = 'Pelvis'
        self.Config['BODY PARTS']['JOINT'] = 'Joint'
        self.Config['BODY PARTS']['JAW'] = 'Jaw'
        self.Config['BODY PARTS']['LIPS'] = 'Lips'
        self.Config['BODY PARTS']['RIGHT SHOULDER'] = 'Right Shoulder'
        self.Config['BODY PARTS']['RIGHT EAR'] = 'Right Ear'
        self.Config['BODY PARTS']['RIGHT FOOT'] = 'Right Foot'
        self.Config['BODY PARTS']['RIGHT HAND'] = 'Right Hand'
        self.Config['BODY PARTS']['RIGHT CALF'] = 'Right Calf'
        self.Config['BODY PARTS']['RIGHT TOE'] = 'Right Toe'
        self.Config['BODY PARTS']['RIGHT THIGH'] = 'Right Thigh'
        self.Config['BODY PARTS']['RIGHT UPPERARM'] = 'Right Upperarm'
        self.Config['BODY PARTS']['RIGHT FOREARM'] = 'Right Forearm'
        self.Config['BODY PARTS']['RIGHT FINGERS'] = 'Right Fingers'
        self.Config['BODY PARTS']['RIGHT ULNA'] = 'Right Ulna'
        self.Config['BODY PARTS']['RIGHT EYE'] = 'Right Eye'
        self.Config['BODY PARTS']['RIGHT CLAVICLE'] = 'Right Clavicle'
        self.Config['BODY PARTS']['LEFT HAND'] = 'Left Hand'
        self.Config['BODY PARTS']['LEFT FOOT'] = 'Left Foot'
        self.Config['BODY PARTS']['LEFT EAR'] = 'Left Ear'
        self.Config['BODY PARTS']['LEFT SHOULDER'] = 'Left Shoulder'
        self.Config['BODY PARTS']['LEFT CALF'] = 'Left Calf'
        self.Config['BODY PARTS']['LEFT THIGH'] = 'Left Thigh'
        self.Config['BODY PARTS']['LEFT UPPERARM'] = 'Left Upperarm'
        self.Config['BODY PARTS']['LEFT FOREARM'] = 'Left Forearm'
        self.Config['BODY PARTS']['LEFT FINGERS'] = 'Left Fingers'
        self.Config['BODY PARTS']['LEFT TOE'] = 'Left Toe'
        self.Config['BODY PARTS']['LEFT ULNA'] = 'Left Ulna'
        self.Config['BODY PARTS']['LEFT EYE'] = 'Left Eye'
        self.Config['BODY PARTS']['LEFT CLAVICLE'] = 'Left Clavicle'

    # --------------------------------------------------------------------------
    def UpdateConfig(self):
        ''' Updates configuration file with the new version changes '''

        self.Config['MESSAGES']['ARROW'] = ('{attacker} killed {victim} with an arrow on the {bodypart} from {distance}m','{victim} took an arrow to the knee, and died anyway. (Distance: {distance})')
        self.Config['MESSAGES']['ARROW SLEEP'] = ('{attacker} killed {victim} with an arrow on the {bodypart}, while {victim} was asleep.','{attacker} killed {victim} with a {weapon}, while sleeping.')

        # VERSION 2.4
        self.Config['BODY PARTS']['LEFT EYE'] = 'Left Eye'
        self.Config['BODY PARTS']['RIGHT EYE'] = 'Right Eye'
        self.Config['BODY PARTS']['LEFT CLAVICLE'] = 'Left Clavicle'
        self.Config['BODY PARTS']['RIGHT CLAVICLE'] = 'Right Clavicle'

        self.Config['CONFIG_VERSION'] = self.latest_cfg

        self.SaveConfig()

    # ==========================================================================
    # <>> MESSAGE FUNTIONS
    # ==========================================================================
    def console(self, text):
        ''' Sends a console message '''

        ServerConsole.PrintColoured(System.ConsoleColor.DarkYellow, '[%s v%s] :: %s' % (self.Title,str(self.Version),text))

    # --------------------------------------------------------------------------
    def say(self, text, color='white', userid='0'):
        ''' Sends a global chat message '''

        if self.prefix:

            rust.BroadcastChat('%s <color=white>' % self.prefix, '</color><color=%s>%s</color>' % (color, text), str(userid))

        else:

            rust.BroadcastChat('<color=%s>%s</color>' % (color, text), None, str(userid))

    # --------------------------------------------------------------------------
    def tell(self, player, text, color='white', userid='0'):
        ''' Sends a global chat message '''

        if self.prefix:

            rust.SendChatMessage(player, '%s <color=white>' % self.prefix, '</color><color=%s>%s</color>' % (color, text), str(userid))

        else:

            rust.SendChatMessage(player, '<color=%s>%s</color>' % (color, text), None, str(userid))

    # --------------------------------------------------------------------------
    def say_filter(self, text, vpos, attacker, raw):

        color = self.Config['COLORS']['MESSAGE COLOR']

        if self.Config['SETTINGS']['DISPLAY MESSAGES IN RADIUS']:

            for player in BasePlayer.activePlayerList:

                if self.get_distance(player.transform.position, vpos) <= float(self.Config['SETTINGS']['MESSAGES RADIUS']):

                    self.tell(player, text, color)

                elif attacker and player == attacker:

                    self.tell(player, text, color)

        else:

            self.say(text, color)

        if self.Config['SETTINGS']['BROADCAST TO CONSOLE']: self.console(raw)

    # ==========================================================================
    # <>> ENTITY'S DEATH FUNTIONS
    # ==========================================================================
    def OnEntityDeath(self, entity, hitinfo):

        # ---------------------------------
        # DEATH TYPES
        # ---------------------------------
        # STAB      = KNIFE / SPEARS / PICKAXE / ARROW / ICEPICK / BEAR TRAP
        # SLASH     = SALVAGE AXE / HATCHET / STONE HATCHET
        # BLUNT     = TORCH / ROCK / SALVAGE HAMMER
        # BITE      = ANIMALS
        # BULLET    = GUNS
        # EXPLOSION = C4
        # HEAT      = CAMP FIRE
        # ---------------------------------
        # METABOLISM / WORLD
        # ---------------------------------
        # FALL   | DROWNED | POISON
        # COLD   | HEAT    | RADIATION
        # HUNGER | THIRST  | BLEEDING
        # ---------------------------------

        death = str(entity.lastDamage).upper()
        victim = entity
        attacker = hitinfo.Initiator
        weapon = str(str(hitinfo.Weapon.LookupShortPrefabName()).replace('wm','').replace('_',' ').strip()).upper() if hitinfo.Weapon else 'No Weapon'
        bodypart = self.get_bodypart(hitinfo.HitBone)

        vpos = victim.transform.position
        if attacker:
            apos = attacker.transform.position
        else:
            apos = vpos

        # DEBUG MESSAGES
        #self.console(self.line)
        #self.console('DEATHTYPE: %s' % death)
        #self.console('VICTIM: %s' % victim)
        #self.console('ATTACKER: %s' % attacker)
        #self.console('WEAPON: %s' % weapon)
        #self.console('BODYPART: %s' % bodypart)
        #self.console(self.line)

        msg = None

        if 'BasePlayer' in str(victim):

            on = victim.IsConnected()

            if death in self.metabolism and self.Config['SETTINGS']['DISPLAY METABOLISM DEATH']:

                msg = self.Config['MESSAGES'][death]

            if death == 'SUICIDE' and self.Config['SETTINGS']['DISPLAY SUICIDE DEATH']:

                msg = self.Config['MESSAGES']['SUICIDE']

            if death == 'EXPLOSION' and self.Config['SETTINGS']['DISPLAY EXPLOSION DEATH']:

                msg = self.Config['MESSAGES']['EXPLOSION']

            if death == 'BITE' and self.Config['SETTINGS']['DISPLAY ANIMAL KILLS']:

                msg = self.Config['MESSAGES']['ANIMAL KILL' if on else 'ANIMAL KILL SLEEP']

            if 'BearTrap' in str(attacker) and self.Config['SETTINGS']['DISPLAY TRAP DEATH']:

                msg = self.Config['MESSAGES']['TRAP']

            elif death in ('SLASH','BLUNT','STAB','BULLET') and self.Config['SETTINGS']['DISPLAY PLAYER KILLS']:

                if 'Bow' in str(hitinfo.Weapon):

                    msg = self.Config['MESSAGES']['ARROW' if on else 'ARROW SLEEP']

                else:

                    death = death if on else '%s SLEEP' % death

                    if death in self.Config['MESSAGES']:

                        msg = self.Config['MESSAGES'][death]

        elif 'BaseNPC' in str(victim) and attacker.ToPlayer() and self.Config['SETTINGS']['DISPLAY ANIMAL DEATH']:

            msg = self.Config['MESSAGES']['ANIMAL DEATH']

        if msg:

            if isinstance(msg, tuple):

                msg = msg[random.Range(0, len(msg))]

            raw = msg

            c = self.Config['COLORS']

            if victim.ToPlayer():
                msg = msg.replace('{victim}', '<color=%s>%s</color>' % (c['VICTIM COLOR'], victim.displayName))
                raw = raw.replace('{victim}', victim.displayName)
            else:
                animal = self.get_animal(victim)
                if animal in self.Config['ANIMALS']:
                    msg = msg.replace('{animal}', '<color=%s>%s</color>' % (c['ANIMAL COLOR'], self.Config['ANIMALS'][animal]))
                    raw = raw.replace('{animal}', self.Config['ANIMALS'][animal])
                else:
                    msg = msg.replace('{animal}', '<color=%s>%s</color>' % (c['ANIMAL COLOR'], animal.title()))
                    raw = raw.replace('{animal}', animal.title())

            if attacker.ToPlayer():
                msg = msg.replace('{attacker}', '<color=%s>%s</color>' % (c['ATTACKER COLOR'], attacker.displayName))
                raw = raw.replace('{attacker}', attacker.displayName)
            else:
                animal = self.get_animal(attacker)
                if animal in self.Config['ANIMALS']:
                    msg = msg.replace('{animal}', '<color=%s>%s</color>' % (c['ANIMAL COLOR'], self.Config['ANIMALS'][animal]))
                    raw = raw.replace('{animal}', self.Config['ANIMALS'][animal])
                else:
                    msg = msg.replace('{animal}', '<color=%s>%s</color>' % (c['ANIMAL COLOR'], animal.title()))
                    raw = raw.replace('{animal}', animal.title())

            if weapon in self.Config['WEAPONS']:
                msg = msg.replace('{weapon}', '<color=%s>%s</color>' % (c['WEAPON COLOR'], self.Config['WEAPONS'][weapon]))
                raw = raw.replace('{weapon}', self.Config['WEAPONS'][weapon])
            else:
                msg = msg.replace('{weapon}', '<color=%s>%s</color>' % (c['WEAPON COLOR'], weapon.title()))
                raw = raw.replace('{weapon}', weapon.title())

            if bodypart in self.Config['BODY PARTS']:
                msg = msg.replace('{bodypart}', '<color=%s>%s</color>' % (c['BODYPART COLOR'], self.Config['BODY PARTS'][bodypart]))
                raw = raw.replace('{bodypart}', self.Config['BODY PARTS'][bodypart])
            else:
                msg = msg.replace('{bodypart}', '<color=%s>%s</color>' % (c['BODYPART COLOR'], bodypart.title()))
                raw = raw.replace('{bodypart}', bodypart.title())

            msg = msg.replace('{distance}', '<color=%s>%.2f</color>' % (c['DISTANCE COLOR'], self.get_distance(vpos, apos)))
            raw = raw.replace('{distance}', '%.2f' % self.get_distance(vpos, apos))

            self.say_filter(msg, vpos, attacker, raw)

    # --------------------------------------------------------------------------
    def get_distance(self, pos1, pos2):
        ''' Returns the distance in between two coordinates '''

        return Vector3.Distance(pos1, pos2)

    # --------------------------------------------------------------------------
    def get_animal(self, entity):
        ''' Formats animals names '''

        return str(str(entity.LookupPrefabName()).split('/')[-1].strip()).upper()

    # --------------------------------------------------------------------------
    def get_bodypart(self, hitbone):
        ''' Returns body hit part '''

        if hitbone:

            hit = StringPool.Get(hitbone).upper().replace('_',' ')
            hit = hit.replace('L ', 'LEFT ').replace('R ', 'RIGHT ')

            for x in range(10):
                hit = hit.replace(str(x), '')

            for x in ('SPINE','UPPERLIP','JAW','NECK','TAIL'):
                if x in hit.split():
                    hit = x

            hit = hit.split()

            if len(hit) > 1:
                hit = '%s %s' % (hit[0], hit[1])
            elif len(hit) == 1:
                hit = '%s' % hit[0]

            return hit

        else:

            return 'No Hit'

    # ==========================================================================
    # <>> PLUGIN DEBUG
    # ==========================================================================
    #def debug_CMD(self, player, cmd, args):

        #player.health = 0
        #player.metabolism.heartrate.value = 100
        #player.metabolism.calories.value = 0
        #player.metabolism.hydration.value = 0
        #player.metabolism.poison.value = 100
        #player.metabolism.radiation_level.value = 0
        #player.metabolism.radiation_poison.value = 100
        #player.metabolism.oxygen.value = -1
        #player.metabolism.temperature.value = -100
        #player.metabolism.bleeding.value = 100
        #player.metabolism.wetness.value = 100
        #player.metabolism.dirtyness.value = 100
        #player.metabolism.comfort.value = 100
        #print(self.line)


# ==============================================================================