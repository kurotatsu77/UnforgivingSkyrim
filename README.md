# Unforgiving Skyrim
Extension to Unforgiving Devices mod by iHateMyKite

Requires DD NG and UD NG.

Added Dasha's items. Added their meshes and textures to package. EDIT: removed them from this mod, as they are now part of DD NG 0.3.8+ Switched to use DD NG versions of those.

Added 3 suits - Cursed, Boxbinder(uses Abadon Dasha's items) and Random(adds random Abadon items).
Custom outfit set - Bound Cunt (BC).

Draugr Replacers - optional, contains replacers for draugrs with MNC support, courtesy of Audhol. Makes them look nice, gimpy and shiny!

Currently there is Abadon Shout - complex shout which acts differently depending on who uses is (male or female) and on whom it used (male or female).
Status: working, subtitles made and sounds used are empty ones until I get good ones. Only a thunder when cast at the moment. Good enough for now.
Quest to obtain it will be launched after observing it from draugrs, proceed to actually get it after completing MQ104 (Dragons Rising).
Added it to draugrs high-levels - bosses and scourges (they have Unrelenting Force normally, now Abadon Shout too), they use it! Yesss! If they have other shouts - they use them randomly too, which is nice. SPID now used to distribute them, much more fun and random.
After using someone (player or follower, doesn't matter) males draugrs are happy and will not attack anymore, but will defend themsleves in case of aggression, which I like! Female draugrs being bitches, beating helpless player into submission :)

Known Problems:
Goo Arrows are not working ATM. Trying to figure out why...
Current implementation of USWhip function support whipping of player only, maybe rewrite is some time later... For now added checks to not to call it when victim is not player. Also need to drop zaz dependency.

Unforgiving Skyrim Goo Quest - done all initial quest, started by visiting Whiterun area while having Black Goo in inventory and knowing it's first effect. Cell now has all items in, prepared alchemy station and enchant station to be opened by side quests.
Research now works, added overrides to lock almost all crafts behind the research.
Research report has hints to how progress.
Generic ingredients effects are researched too.
Now it is a solid foundation to build bunch of content in form of side quests and repeatable activities.
Added Masochism stat tracking for use in dialogues and events, now some actions would be unlocked only when value high enough.
Expanded dialogues on the Goo Research Quest to provide better motivation for player to get involved.
Side quest to get Alchemy station done, if player chooses fun payment options - there will be repeatable action with Arcadia.
Side quest to get the DD Book is done, quest for the Urag research sharing is done. It turned out quite big and complicated. Who needs simple and boring, right? :)
Side quest to get the Enchanting Station done. Quest quest uses BC set. Added repeatables with it to 4 NPCs (Calcelmo, Farengar, Arcadia and Urag).
When all research is done - Nodaba becomes merchant, selling various UD goodies and making good money off it.

Spiders, falmers and chaurus poison now have the chance to add Abadon restraints.

Current ideas in various stages of planning:
Repeatable activity - become bondage entertainment at Bannered Mare  for Hulda.
NPC bondage rescue radiant quest. 
NPC bondage punishment radiant quest: idea of getting orders to punish bad girls by coming to them, binding and leaving them locked at public place (maybe inn?) in stocks or other furniture to humiliate them. And imagine choices player would have if one day she would receive order to punish herself! :D Boring option would be to pay out bounty to the client, maybe with a bit of extra. Fun options would be going through it or even offer more harsh treatment, because gold is good! 
Repeatable quest of small chance for research to fail, which will cause Nodaba to be locked in devices. This will prompt a side quest which will tell the player to return to the house and help her out. Player can ignore it, in which can she have to help herself (hopefully AI will work as intended). But by helping her, there might be some kind of reward (bonus research points, discount on research or just money).
Idea of bondage spell - touch type, uses goo to function, some sexy quest obtain? Morthal's mage (Falion?) or Solstheim one (Tellvanni guy, name?) seems nice for it.
People asked for distance spell, kinda of conjure goo arrow and shoot it at target? Gotta make sure it's useful, if not binding target it has to damage it. Not too OP?
Crowd reactions to the device escape attempts and orgasms. Possible reactions are neutral(applauding, laughing, pointing fingers), positive(if failed to remove - help out, maybe even completely remove the device), negative(fuck if high arousal[gotta check for plugs/gags here, maybe add possibility of removal], retighten device, maybe even beat up to make fail[do we have fitting anims?]? add contraption?). Gotta tie it to morality. Will need to use cloak spells to gather, LOS check? Humans only, how hard to implement draugrs, falmers, dwemer constructs? Maybe make cloak spell to calm hostiles, making it DHLP lite?
Need to make dwemer constructs unforgiving. Touch spell, distribute via SPID, 2 varieties? 1 - equals updated black goo, 2 - equals con black goo. Probability based, tie to stamina %? When activated - fuck first, then apply goo effects with shader on?
Quest to practice lockpicking, guy in Thief guild in Ragged Flagon Cistern (name?). Possibilites - get tied and escape for massive lockpicking skill buff? and maybe perks? Some predefined sets?
Teacher's Pet piercings, fuck to learn skills (and maybe perks?), better when in bondage. Who would be the most fitting candidate to develop something like that?
Use the new extreme hood as hypno hood, conditioning wearer into becoming bondage fuck toy. Add aphrodisiac effect like cursed gasmask, use particles with sexy images (learn from Audhol). Condition should slowly weaken with time without the hood. Telvanni guy seems like the best candidate as developer in need of tester.
Improve on Nodaba's interaction - add repeatable dialogues with extended explanations. Possibly make player suffer some kind of bondage consequences, depending on what is available, i.e. eat goo normal or concentrated, wear BC set or Abadon Plug, etc.
Possible flavor addition - when turning in Enchanting station quest while dressed up in BC outfit can have a bit different dialogue with Nodaba.
Possible end quest item - book with all crafting recipes in it for the reference. Nodaba can give it when quest complete and/or sell it.
Bring that book to Urag and he will use it to tell you about things have not shared with him? Or simply make him buy it for hefty sum to mark it all as shared?
Add to debug menu kickstart for Goo Research quest.
Possible quick research bypass - use Belethor? Hint at him wanting to talk after research end, bring that book, he tells he knows it all already and player should've came to him. If come to him before research ends - he will offer all the knowledge either for huge sum of gold or some naughty bondage sexy times. Bound attraction at his store, use contraptions?
Alternative ways to learn Abadon Shout via Greybeards: 1 - buy book from Angeir(the only talking one), 2 - Add another Greybeard(name?), which knows the Shout and uses it without target's consent, always full power, maybe tie it to his arousal. Design some small interior cell, access via trapdoor in some corner? Need to make sure no clash with overhauls...

Abadon Living Latex/Abadon Slime (same thing, just flavour names although could be different things)
A new custom enemy/NPC (just humanoid equipped with full latex suit/gloves/hood to look as doll like as possible) that can randomly spawn either in the wild or in same way as thugs/assassins that target you. 
When it does spawn it can have multiple versions; 
it can just be hostile, attacking with Abadon shout or with 'perfect' Abadon weapons that will always bind you (or at least high chance)
it can be 'friendly' and initiate conversation with you like hired thugs and equip you with any of the things you've unlocked with Urag including extreme stuff like execution potion. It can reward you with a large amount of things like gold/abadon gems/ingots etc to compensate player but the main point of it is that the player doesn't have a choice, you WILL be getting bound.
If you are bound already when you come across a living latex then they would have some fun with you, using you and could potentially add extra gear depending on how you are bound already.
and finally it can 'encase' you, absorbing you into it, turning you into a doll and equipping itself to you as a new Living Latex outfit, with some new living latex tentacle plugs that fill your holes and latex tentacle gag filling your mouth (just custom plugs with flavour text/effects mostly, not expecting new models or anything to that extreme)
like the execution set, this would be extremely hard to remove and would be regularly morphing its shape, equiping various latex restraints to bind you tightly. a living latex sample would also be something you can research or show to urag to test too  

