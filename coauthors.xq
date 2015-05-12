<authors_coauthors>&#xa;
{
for $author in distinct-values(/dblp//author)
	let $author_pub := /dblp/*[author=$author]
	let $all_coauthor := distinct-values($author_pub/author[.!=$author])
	let $number := count($all_coauthor)
	order by $author
	return (element author
	{
		'&#xa;',<name>{$author}</name>,'&#xa;',
		element coauthors
		{
			attribute number {$number},
			for $coauthor in distinct-values($all_coauthor)
			let $nb_joint := count($all_coauthor[.=$coauthor])
			return (element coauthor
					{	
						'&#xa;',<name>{$coauthor}</name>,'&#xa;',
						<nb_joint_pubs>{$nb_joint}</nb_joint_pubs>, '&#xa;'
				}, '&#xa;')
		}
	}, '&#xa;')
}
</authors_coauthors>
