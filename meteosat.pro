pro meteosat

plik = 'D:\Mateusz\dane\claas2_level2_aux_data.nc'
ctx = 'D:\Mateusz\dane\ctx\CTXin20090723203000305SVMSG01MD.nc'

lat = MAKE_ARRAY(3636,3636)
lon = MAKE_ARRAY(3636,3636)
cth = MAKE_ARRAY(3636,3636)

wsp = NCDF_OPEN(plik, /nowrite)
wys = NCDF_OPEN(ctx, /nowrite)
NCDF_VARGET, wsp, 'lat', lat
NCDF_VARGET, wsp, 'lon', lon
NCDF_VARGET, wys, 'cth', cth
NCDF_CLOSE, wsp
NCDF_CLOSE, wys

GdzieChmury = WHERE(cth GT 0) ;abc
H_Chmur = cth[GdzieChmury]
GdzieChmury_lon = lon[GdzieChmury]
GdzieChmury_lat = lat[GdzieChmury]

;cc = MAKE_ARRAY(3636,3636)
;FOR dl=0, 3635 DO BEGIN
;  FOR szer=0, 3635 DO BEGIN
;    a = lon[dl,szer]
;    b = lat[dl,szer]
;    c = cth[dl,szer]
;    IF c EQ -1 THEN c=0
;    cc[dl,szer] = c
;    ;c = cth[a,b]
;    ENDFOR
;ENDFOR
Map_Set, Position=[0.1, 0.1, 0.8, 0.9], /SATELLITE, SAT_P=[10,0,0], REVERSE=2
plots, GdzieChmury_lon, GdzieChmury_lat, Psym=3, symsize=1
Map_Continents, color=100B
Map_Grid, /Box
LoadCT, 2
zcolors = BytScl(h_chmur, Top=!D.Table_Size-1)
for j=0, 5369967 do polyfill, circle(GdzieChmury_lon(j), GdzieChmury_lat(j)), /fill, color=zcolors(j), /device
colorbar, position=[0.85, 0.15, 0.90, 0.95], range=[min(h_chmur), max(h_chmur)], /vertical, format='(I5)', title='z values'

;WRITE_TIFF, 'D:\mateusz\dane\meteosat_proba.tif', TVRD(/TRUE)
;Map_Set, Limit=[-90, -180, 90, 180], Position=[0.1, 0.1, 0.8, 0.9]
;Map_Continents
;Plots, lon, lat,cc, PSym=3, SymSize=0.5
;Map_Grid, /Box
;p = GdzieChmury_lon[258900]
;q = GdzieChmury_lat[258900]
;r = H_Chmur[258900]
;s = H_Chmur[p,q]
;print, s

;Map_Set, Position=[0.1, 0.1, 0.8, 0.9], /SATELLITE, SAT_P=[10,0,0], REVERSE=2
;Plots, GdzieChmury_lon, GdzieChmury_lat, PSym=3, SymSize=0.5
;Map_Continents, color=100B
;Map_Grid, /Box, color=225
;
;
;WRITE_TIFF, 'D:\mateusz\dane\meteosat.tif', TVRD(/TRUE)

;Map_Set, Position=[0.1, 0.1, 0.8, 0.9], /SATELLITE, SAT_P=[10,0,0], latdel=10, londel=10
;CONTOUR, cth, lon, lat, /overplot, XStyle=1, YStyle=1, /noerase, /cell_fill
;contour, cth, lon, lat, /overplot, /irregular
;
;Map_Grid, box_axes=1, label=1, color=255
;Map_Continents, /continents, mlinethick=2, color=255

;m = map('goes', grid_longitude=20, grid_latitude=20)
;ct = colortable(72, /reverse)
;q = contour(cc, overplot=m, grid_units='meters', rgb_table=ct, title='abcd')
;mc = mapcontinents(fill_color="orange")
;gr = mapgrid(color="red", fill_color="yellow",/box_axes, latitude_min=-30, latitude_max=30, longitude_min=-30, longitude_max=30, transparency=50)





;cb = colorbar(target=q, title='costam')
;m = map('mercator')
;ct = colortable(72, /reverse)
;
;aa = contour(cc, fill=33, grid_units='meters', title='abcd')
;mc = mapcontinents()
;cb = colorbar(target=aa, title='qwertyuiop')
;x = make_array(600,600)
;x = lon[1518:2118, 1518:2118]
;y = make_array(600,600)
;y = lat[1518:2118,1518:2118]
;h = make_array(600,600)
;h = cc[1518:2118,1518:2118]
;
;m = map('Robinson')
;ct = colortable(72, /reverse)
;q = contour(h,x,y, overplot=m, grid_units='meters', rgb_table=ct, title='abcd')
;mc = mapcontinents()
;cb = colorbar(target=q, title='costam')

END
