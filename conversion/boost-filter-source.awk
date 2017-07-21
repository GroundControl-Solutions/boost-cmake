BEGIN {FS="/"}

/\.vcx?proj(\.filters)?$/ {next}
/\.sln$/ {next}
/\.suo$/ {next}
match($NF,/^\.git.*/) {next}
match($NF,/^\..*\.yml$/) {next}
$NF=="CMakeLists.txt" {next}

{
	for (i=3; i<=NF; ++i)
	{
		if ($i=="doc" || ($i=="boost" && $(i-1)=="include") || $i=="cmake" || ($i=="test" && $(i-2)!="include"))
			next;
	}
}

{print}
