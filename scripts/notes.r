library(qlcMatrix)
data(bibles)

sel <- intersect(names(bibles$eng), names(bibles$deu))

write(bibles$eng[sel],"eng.txt")
write(bibles$deu[sel],"deu.txt")

library(word.alignment)

align <- word_alignIBM1("eng.txt","deu.txt")






system.time(sim <- sim.words(bibles$eng, bibles$deu))

id <- "41001003"
w_eng <- tolower(strsplit(bibles$eng[id], " ")[[1]])
w_deu <- tolower(strsplit(bibles$deu[id], " ")[[1]])

image(sim[w_eng,w_deu])




show_align <- function(id, t1, t2, data = sim) {
	
	w1 <- tolower(strsplit(t1[id], " ")[[1]])
	w2 <- tolower(strsplit(t2[id], " ")[[1]])

	lattice::levelplot(as.matrix(data[w1,w2])
		, cex=.5
		, xlab = ""
		, ylab = ""
		, scales=list(x=list(rot=90))
		, col.regions = gray(100:0/100)
		)
}

show_align("41001004", bibles$eng, bibles$deu, sim)


sim <- sim.words(bibles$deu, bibles$aak)^.7
show_align("41001004", bibles$deu, bibles$aak, sim)

sapply(w1,function(x) {sort(sim[x,], decreasing=T)[1:3]}, simplify=F)


show_best <- function(word, data, max = 3) {
	
	s <- sort(data[word,], decreasing = TRUE)
	return(s[1:max])
	
}

show_best("wüste", sim)


tmp <- tolower(strsplit(bibles$aak["41001004"], " ")[[1]])

show_best(tmp[39],t(sim))

sapply(tmp,show_best, data=t(sim), simplify=F)


W1 <- wals.feature("1a")

map.feature(lang.gltc(W1$glottocode), W1$'1a')

map.feature(W1$language, W1$'1a', latitude = W1$latitude, longitude = W1$longitude)