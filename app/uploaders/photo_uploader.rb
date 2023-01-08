# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  # Добавляем обработчик, чтобы можно было менять размер фотографий
  # и делать миниатюрные версии
  include CarrierWave::RMagick

  # Если мы работаем в локальной версии нашего приложения,
  # фотографии хранятся прямо в файловой системе, иначе используем fog
  # для загрузки их на Amazon S3
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Папка, в которой будут храниться все наши загруженные файлы
  # например, uploas/photo/photo/1
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Фотографию надо обрезать/уменьшить так, чтобы получился квадрат 400x400
  process resize_to_fit: [800, 800]

  # А потом нужно сделать миниатюрную версию 100x100
  version :thumb do
    process :resize_to_fit => [100, 100]
  end

  # Мы разрешаем для загрузки только файлы с расширением картинок
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
