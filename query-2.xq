for $proceeding in /dblp/proceedings
let $key := /dblp/$proceeding/@key
order by $proceeding/title
return (element proceedings{
	'&#xa;',<proc_title>{$proceeding/title/text()}</proc_title>,'&#xa;',
	for $title in /dblp/inproceedings[crossref=$key]
	order by $title
	return (<title>{$title/title/text()}</title>, '&#xa;')
},'&#xa;')
