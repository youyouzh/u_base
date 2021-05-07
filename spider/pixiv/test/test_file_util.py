import os

from spider.pixiv.arrange.file_util import *
from spider.pixiv.arrange.file_util import get_download_users, is_download_user
from u_base import u_unittest


def test_get_base_path():
    actual_base_path = r'G:\Projects\Python_Projects\python-base\spider\pixiv\crawler\result'
    path_name = 'collect'
    u_unittest.assert_eq(os.path.join(actual_base_path, path_name), get_base_path(path_name))

    # 包含子路径的情况
    path_name = r'collect\ignore'
    u_unittest.assert_eq(os.path.join(actual_base_path, path_name), get_base_path(path_name))


def test_get_illust_id():
    u_unittest.assert_eq(42344051, get_illust_id(r'G:\Projects\illusts\8000-9000\42344051_p0-3日で消えり.jpg'))
    u_unittest.assert_eq(42344051, get_illust_id(r'42344051_p0-3日で消えり.jpg'))


def test_get_all_image_file_path():
    count = len(get_all_image_file_path())
    u_unittest.assert_lt(0, count)


def test_get_download_user_ids():
    user_ids = get_download_users()
    u_unittest.assert_true(len(user_ids) > 0)


def test_is_download_user():
    u_unittest.assert_true(is_download_user(22124330))
    u_unittest.assert_false(is_download_user(-1))
