generate 'controller Home index'
git add: '.'
git commit: %Q{-m 'home#index placeholder'}

gsub_file 'config/routes.rb', %r{get ['"]home[/#]index['"]}, "root 'home#index'"
git add: 'config/routes.rb'
git commit: %Q{-m 'root home#index'}
