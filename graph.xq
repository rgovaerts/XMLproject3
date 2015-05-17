declare namespace local = "local";

declare function local:distance($queue, $distance, $author1, $alreadyMet) {
	let $newAlreadyMet := distinct-values(($queue, $alreadyMet))
	let $newQueue := distinct-values(fn:doc("dblp-excerpt.xml")/dblp/*[some $str in author satisfies(exists(index-of($queue, $str)))]/author[empty(index-of($newAlreadyMet,.))])
	for $author2 in $queue
	return (element distance
    {
     attribute author1 {$author1},
     attribute author2 {$author2},
     attribute distance {$distance}
    }, local:distance($newQueue, $distance +1, $author1, $newAlreadyMet))
};

<distances> &#xa;
	{
		for $author in distinct-values(/dblp//author)
	    let $alreadyMet := $author
	    let $queue := /dblp/*[author=$author]/author[.!=$author]
	    let $allResult := local:distance($queue, 1, $author, $alreadyMet)
	    for $author1 in distinct-values($allResult/@author1)
		for $author2 in distinct-values($allResult[@author1 = $author1]/@author2)
		return (<distance author1="{$author1}" author2="{$author2}" distance="{($allResult[@author1=$author1 and @author2=$author2]/@distance)[1]}"/>,'&#xa;')	    
	}
</distances>
