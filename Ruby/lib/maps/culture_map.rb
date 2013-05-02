$CM_CK2_EU3 = {
  'norwegian' => 'norwegian',
  'swedish' => 'swedish',
  'danish' => 'danish',
  'german' => 'SPECIAL',
  'english' => 'english',
  'saxon' => 'english',
  'dutch' => 'SPECIAL',
  'frankish' => 'SPECIAL',
  'norman' => 'normand',
  'occitan' => 'occitain',
  'italian' => 'SPECIAL',
  'basque' => 'basque',
  'castillan' => 'SPECIAL',
  'portuguese' => 'galician',
  'catalan' => 'catalan',
  'armenian' => 'armenian',
  'greek' => 'greek',
  'alan' => 'tartar',
  'georgian' => 'georgian',
  'irish' => 'irish',
  'scottish' => 'SPECIAL',
  'breton' => 'breton',
  'welsh' => 'welsh',
  'finnish' => 'SPECIAL',
  'lappish' => 'sapmi',
  'ugricbaltic' => 'estonian',
  'komi' => 'uralic',
  'lettigallish' => 'latvian',
  'lithuanian' => 'lithuanian',
  'prussian' => 'old_prussian',
  'turkish' => 'SPECIAL',
  'mongol' => 'SPECIAL',
  'cuman' => 'tartar',
  'pecheneg' => 'tartar',
  'bedouin_arabic' => 'bedouin_arabic',
  'levantine_arabic' => 'al_misr_arabic',
  'egyptian_arabic' => 'al_misr_arabic',
  'maghreb_arabic' => 'maghreb_arabic',
  'andalusian_arabic' => 'andalucian',
  'russian' => 'SPECIAL',
  'pommeranian' => 'polish',
  'bohemian' => 'czech',
  'polish' => 'SPECIAL',
  'croatian' => 'croatian',
  'serbian' => 'serbian',
  'vlach' => 'romanian',
  'bulgarian' => 'bulgarian',
  'hungarian' => 'hungarian',
  'persian' => 'persian',
  'kurdish' => 'persian',
  'ethiopian' => 'ethiopian',
  'manden' => 'mali',
  'nahuatl' => 'aztek',
  'romanian' => 'romanian'
}

  def convert_special_culture(culture, title)
    new_culture = case culture
                    when 'german' then get_german(title)
                    when 'scottish' then get_scottish(title)
                    when 'dutch' then get_dutch(title)
                    when 'frankish' then get_frankish(title)
                    when 'italian' then get_italian(title)
                    when 'castillan' then get_castillan(title)
                    when 'finnish' then get_finnish(title)
                    when 'turkish' then get_turkish(title)
                    when 'mongol' then get_mongol(title)
                    when 'russian' then get_russian(title)
                    when 'polish' then get_polish(title)
                  end
    new_culture
  end

### GERMAN ###

  def get_german(title)
    if is_pommeranian?(title) then culture = 'pommeranian'
      elsif is_prussian?(title) then culture = 'prussian'
      elsif is_hannoverian?(title) then culture = 'hannoverian'
      elsif is_hessian?(title) then culture = 'hessian'
      elsif is_saxon?(title) then culture = 'saxon'
      elsif is_rheinlaender?(title) then culture = 'rheinlaender'
      elsif is_austrian?(title) then culture = 'austrian'
      else culture = 'bavarian'   
    end
    culture
  end

  def is_pommeranian?(title)
    titles = ['c_wolgast','c_stettin', 'c_slupsk', 'c_danzig', 'c_chelminskie',
               'c_mecklemburg', 'c_rugen', 'c_rostock', 'c_werle']
    titles.include? title
  end

  def is_prussian?(title)
    titles = %w[c_lettigalians c_osel c_livs c_dorpat c_marienburg
              c_tartu c_liivimaa c_saaremaa c_latgale
              c_sambia c_galindia c_west_dvina c_polotsk c_aukshayts
              c_zhmud c_sudovia c_kurs c_zemigalians c_memel c_scalovia
              ]
    titles.include? title
  end

  def is_hannoverian?(title)
    titles = ['c_oldenburg', 'c_osnabruck', 'c_gottingen', 'c_braunschweig', 
              'c_luneburg', 'c_celle', 'c_blekinge', 'c_halland', 'c_skane', 
              'c_bornholm', 'c_fyn', 'c_sjaelland', 'c_slesvig', 'c_jylland',
              'c_hamburg', 'c_lubeck', 'c_holstein', 'c_bremen'
              ]
    titles.include? title
  end

  def is_hessian?(title)
    titles = ['c_nassau', 'c_thuringen']
    titles.include? title
  end

  def is_saxon?(title)
    titles = ['c_weimar', 'c_anhalt', 'c_plauen', 'c_altmark', 'c_brandenburg',
              'c_meissen', 'c_lausitz', 'c_jacwiez', 'c_yatvyagi', 'c_plock',
              'c_czersk', 'c_gnieznienskie', 'c_lubusz', 'c_poznanskie', 'c_kaliskie',
              'c_krakowskie', 'c_sandomierskie', 'c_sacz', 'c_kujawy', 'c_sieradzko-leczyckie'
              ]
    titles.include? title
  end

  def is_rheinlaender?(title)
    titles = %w[c_munster c_kleve c_julich c_loon c_koln c_provence 
              c_venaissin c_forcalquier c_savoie c_valais c_geneve
              c_forez c_lyon c_dauphine_viennois c_besancon c_bourgogne c_neuchatel
              c_aargau c_bern c_schwyz c_grisons c_luxembourg c_liege
              c_lorraine c_verdun c_saintois c_trier c_pfalz c_metz
              c_nordgau c_sundgau c_saluzzo c_monferrato c_piemonte
              c_pavia c_lombardia c_trent c_brescia c_cremona c_nice
              c_genoa c_parma c_modena c_lucca c_firenze c_siena c_pisa
              c_piombino c_narbonne c_carcassonne c_toulouse c_rouergue 
              c_montpellier c_viviers c_angouleme c_bordeaux c_agen c_perigord 
              c_albret c_labourd c_bearn c_armagnac c_foix c_poitiers c_thouars 
              c_saintonge c_lusignan c_auvergne c_gevaudan c_la_marche c_bourbon 
              c_limousin c_bourges c_tourraine c_reims c_troyes c_sens 
              c_auxerre c_dijon c_nevers c_macon c_charolais c_chalons
              ]
    titles.include? title
  end

  def is_austrian?(title)
    titles = %[c_passau c_znojmo c_osterreich c_steiermark c_chur c_st_gallen
              c_tirol c_innsbruck c_aquileia c_karnten c_krain c_istria c_fejer
              c_pecs c_szekezfehervar c_vas c_esztergom c_pressburg c_sopron
              c_trencin c_nitra c_gemer c_orava c_saris c_bereg c_abauj c_marmaros
              c_csanad c_pest c_heves c_feher c_bihar c_szekelyfold c_temes c_bacs
              c_varadzin c_zagreb c_krizevci c_usora c_rama c_veglia c_senj
              c_zachlumia c_zadar c_split c_temes c_bacs c_venezia c_verona 
              c_mantua c_padova c_padua c_treviso c_ravenna c_bologna c_ferrara
              c_urbino c_ancona c_spoleto c_aprutium
              ]
    titles.include? title
  end

### SCOTTISH ###

  def get_scottish(title)
    culture = 'lowland_scottish' if is_lowland_scottish?(title)
    culture ||= 'highland_scottish'
    culture = 'scottish' unless $VERSION == '1'
    culture
  end

  def is_lowland_scottish?(title)
    titles = %w[c_clydesdale c_carrick c_galloway c_teviotdale c_lothian c_dunbar]
    titles.include? title
  end

### DUTCH ###

  def get_dutch(title)
    culture = 'flemish' if is_flemish?(title)
    culture ||= 'dutch'
    culture
  end

  def is_flemish?(title)
    %w[c_anjou c_maine c_eu c_arques c_rouen c_vexin c_evreux c_avranches
       c_mortain c_guines c_boulougne c_yperen c_artois c_brugge c_gent
       c_amiens c_ile_de_france c_vermandois].include? title
  end

### FRANKISH ###

  def get_frankish(title)
    culture = 'burgundian' if is_burgundian?(title)
    culture = 'wallonian' if is_wallonian?(title)
    culture ||= 'aquitaine'
    culture
  end

  def is_burgundian?(title)
    %w[c_auxerre c_dijon c_nevers c_macon c_charolais c_chalons c_savoie
      c_valais c_geneve c_forez c_lyon c_dauphine_viennois c_besancon c_neuchatel
      c_aargau c_bern c_schwyz c_bourgogne].include? title
  end

  def is_wallonian?(title)
    %w[c_zeeland c_holland c_westfriesland c_sticht c_gelre c_frisia c_ostfriestland
      c_breda c_hainaut c_brabant c_guines c_boulougne c_yperen c_artois c_brugge
      c_gent].include? title
  end

### ITALIAN ###

  def get_italian(title)
    culture = 'lombard' if is_lombard?(title)
    culture = 'sicilian' if is_sicilian?(title)
    culture ||= 'umbrian'
    culture
  end

  def is_lombard?(title)
    %w[c_venezia c_verona c_mantua c_padova c_padua c_treviso c_saluzzo c_monferrato
      c_genoa c_piemonte c_nice c_pavia c_lombardia c_trent c_brescia c_cremona
      c_corsica c_arborea c_cagliari c_lucca c_firenze c_siena].include? title
  end

  def is_sicilian?(title)
    %w[c_benevento c_foggia c_napoli c_capua c_lecce c_bari c_apulia c_salerno
      c_taranto c_consenza c_catanzaro c_reggio c_messina c_palermo c_trapani
      c_agrigento c_girgenti c_siracusa c_malta].include? title
  end

### CASTILLAN ###

  def get_castillan(title)
    culture = 'galician' if is_galician?(title)
    culture ||= 'castillian'
  end

  def is_galician?(title)
    %w[c_coruna c_santiago c_porto c_coimbra c_castelo_branco 
      c_braganza].include? title
  end

### FINNISH ###

  def get_finnish(title)
    culture = 'ingrian' if is_ingrian?(title)
    culture = 'estonian' if is_estonian?(title)
    culture = 'karelian' if is_karelian?(title) && $VERSION != '1'
    culture ||= 'finnish'
    culture
  end

  def is_ingrian?(title)
    %w[c_bezhetsky_verh c_ladoga c_toropets c_torzhok c_pskov c_novgorod
      c_velikiye_luki c_luki c_novgorod_seversky c_uglich c_pereyaslavl_zalessky
      c_rostov c_kostroma c_yaroslavl c_vladimir c_suzdal c_nizhny_novgorod
      c_gorodez c_galich_mersky c_moskva c_mozhaysk].include? title
  end

  def is_estonian?(title)
    %w[c_reval c_kalevan c_narva c_vodi c_lettigalians c_osel c_livs c_dorpat 
      c_tartu c_liivimaa c_saaremaa c_latgale].include? title
  end

  def is_karelian?(title)
    %w[].include? title
  end

### TURKISH ###

  def get_turkish(title)
    'turkish'
  end

### MONGOL ###

  def get_mongol(title)
    'tartar'
  end

### RUSSIAN ###

  def get_russian(title)
    'russian'
  end

### POLISH ###

  def get_polish(title)
    'polish'
  end

