$CM_CK2_EU3 = {
  'norwegian' => 'norwegian',
  'swedish' => 'swedish',
  'danish' => 'danish',
  'german' => 'SPECIAL',
  'english' => 'english',
  'saxon' => 'SPECIAL',
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
                    when 'saxon' then get_saxon(title)
                    when 'dutch' then get_dutch(title)
                    when 'frankish' then get_frankish(title)
                    when 'italian' then get_italian(title)
                    when 'castillian' then get_castillian(title)
                    when 'scottish' then get_scottish(title)
                    when 'finnish' then get_finnish(title)
                    when 'turkish' then get_turkish(title)
                    when 'mongol' then get_mongol(title)
                    when 'russian' then get_russian(title)
                    when 'polish' then get_polish(title)
                  end
    new_culture
  end

  def get_german(title)
    culture = case title
                when is_pommeranian?(title) then 'pommeranian'
                when is_prussian?(title) then 'prussian'
                when is_hannoverian?(title) then 'hannoverian'
                when is_hessian?(title) then 'hessian'
                when is_saxon?(title) then 'saxon'
                when is_rheinlaender?(title) then 'rheinlaender'
                when is_austrian?(title) then 'austrian'
                else 'bavarian'   
              end
    culture
  end

  def is_pommeranian?(title)
    titles = ['c_wolgast','c_stettin', 'c_slupsk', 'c_danzig', 'c_chelminskie',
               'c_mecklemburg', 'c_rugen', 'c_rostock', 'c_werle']
    titles.include? title
  end

  def is_prussian?(title)
    titles = []
  end

  def get_saxon(title)
    'english'
  end

  def get_dutch(title)
    'dutch'
  end

  def get_frankish(title)
    'aquitaine'
  end

  def get_italian(title)
    'umbrian'
  end

  def get_castillian(title)
    'castillian'
  end

  def get_scottish(title)
    culture = 'highlandscottish' if $VERSION == 1
    culture ||= 'scottish'
    culture
  end

  def get_finnish(title)
    'finnish'
  end

  def get_turkish(title)
    'turkish'
  end

  def get_mongol(title)
    'tartar'
  end

  def get_russian(title)
    'russian'
  end

  def get_polish(title)
    'polish'
  end

