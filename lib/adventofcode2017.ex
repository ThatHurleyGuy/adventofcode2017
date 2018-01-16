defmodule AdventOfCode2017 do
  def main([day]) do
    result = case day do
      "1" -> Day1.sum("823936645345581272695677318513459491834641129844393742672553544439126314399846773234845535593355348931499496184839582118817689171948635864427852215325421433717458975771369522138766248225963242168658975326354785415252974294317138511141826226866364555761117178764543435899886711426319675443679829181257496966219435831621565519667989898725836639626681645821714861443141893427672384716732765884844772433374798185955741311116365899659833634237938878181367317218635539667357364295754744829595842962773524584225427969467467611641591834876769829719248136613147351298534885563144114336211961674392912181735773851634298227454157885241769156811787611897349965331474217223461176896643242975397227859696554492996937235423272549348349528559432214521551656971136859972232854126262349381254424597348874447736545722261957871275935756764184378994167427983811716675476257858556464755677478725146588747147857375293675711575747132471727933773512571368467386151966568598964631331428869762151853634362356935751298121849281442128796517663482391226174256395515166361514442624944181255952124524815268864131969151433888721213595267927325759562132732586252438456569556992685896517565257787464673718221817783929691626876446423134331749327322367571432532857235214364221471769481667118117729326429556357572421333798517168997863151927281418238491791975399357393494751913155219862399959646993428921878798119215675548847845477994836744929918954159722827194721564121532315459611433157384994543332773796862165243183378464731546787498174844781781139571984272235872866886275879944921329959736315296733981313643956576956851762149275521949177991988236529475373595217665112434727744235789852852765675189342753695377219374791548554786671473733124951946779531847479755363363288448281622183736545494372344785112312749694167483996738384351293899149136857728545977442763489799693492319549773328626918874718387697878235744154491677922317518952687439655962477734559232755624943644966227973617788182213621899579391324399386146423427262874437992579573858589183571854577861459758534348533553925167947139351819511798829977371215856637215221838924612644785498936263849489519896548811254628976642391428413984281758771868781714266261781359762798")
      "1.2" -> Day1.sum_circle("823936645345581272695677318513459491834641129844393742672553544439126314399846773234845535593355348931499496184839582118817689171948635864427852215325421433717458975771369522138766248225963242168658975326354785415252974294317138511141826226866364555761117178764543435899886711426319675443679829181257496966219435831621565519667989898725836639626681645821714861443141893427672384716732765884844772433374798185955741311116365899659833634237938878181367317218635539667357364295754744829595842962773524584225427969467467611641591834876769829719248136613147351298534885563144114336211961674392912181735773851634298227454157885241769156811787611897349965331474217223461176896643242975397227859696554492996937235423272549348349528559432214521551656971136859972232854126262349381254424597348874447736545722261957871275935756764184378994167427983811716675476257858556464755677478725146588747147857375293675711575747132471727933773512571368467386151966568598964631331428869762151853634362356935751298121849281442128796517663482391226174256395515166361514442624944181255952124524815268864131969151433888721213595267927325759562132732586252438456569556992685896517565257787464673718221817783929691626876446423134331749327322367571432532857235214364221471769481667118117729326429556357572421333798517168997863151927281418238491791975399357393494751913155219862399959646993428921878798119215675548847845477994836744929918954159722827194721564121532315459611433157384994543332773796862165243183378464731546787498174844781781139571984272235872866886275879944921329959736315296733981313643956576956851762149275521949177991988236529475373595217665112434727744235789852852765675189342753695377219374791548554786671473733124951946779531847479755363363288448281622183736545494372344785112312749694167483996738384351293899149136857728545977442763489799693492319549773328626918874718387697878235744154491677922317518952687439655962477734559232755624943644966227973617788182213621899579391324399386146423427262874437992579573858589183571854577861459758534348533553925167947139351819511798829977371215856637215221838924612644785498936263849489519896548811254628976642391428413984281758771868781714266261781359762798")
      "2" -> Day2.checksum("data/day2.txt")
      "2.2" -> Day2.checksum_division("data/day2.txt")
      "3" -> Day3.shortest_path(265149)
      "4" -> Day4.count_valid_passwords("data/day4.txt")
      "4.2" -> Day4.count_valid_passwords_part_2("data/day4.txt")
      "5" -> Day5.part1("data/day5.txt")
      "5.2" -> Day5.part2("data/day5.txt")
      "6" -> Day6.count_steps("data/day6.txt")
      "6.2" -> Day6.count_infinite_loop("data/day6.txt")
      "8" -> Day8.largest_register("data/day8.txt")
      "8.2" -> Day8.largest_register_ever("data/day8.txt")
      "9" -> Day9.groups("data/day9.txt")
      "9.2" -> Day9.garbage("data/day9.txt")
      "10" -> Day10.first_multiple([212,254,178,237,2,0,1,54,167,92,117,125,255,61,159,164])
      "10.2" -> Day10.full_hash("212,254,178,237,2,0,1,54,167,92,117,125,255,61,159,164")
      "11" -> Day11.distance("data/day11.txt")
      "11.2" -> Day11.furthest_distance("data/day11.txt")
      "12" -> Day12.count("data/day12.txt")
      "12.2" -> Day12.count_groups("data/day12.txt")
      "13" -> Day13.severity("data/day13.txt")
      "13.2" -> Day13.find_delay("data/day13.txt")
      "14" -> Day14.count_used("wenycdww")
      "14.2" -> Day14.count_regions("wenycdww")
      "15" -> Day15.judge(883, 1, 879, 1, 40000000)
      "15.2" -> Day15.judge(883, 4, 879, 8, 5000000)
      "16" -> Day16.dance("data/day16.txt")
      "16.2" -> Day16.dance("data/day16.txt", 1000000000)
      "17" -> Day17.spinlock(301, 2017, 2017)
      "17.2" -> Day17.part2(301, 50000000, 0)
    end

    IO.inspect result, limit: :infinity
  end
end
