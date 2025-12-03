#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
邮箱正则表达式匹配示例
匹配邮箱，但排除包含星号(*)的邮箱
"""

import re

# 方法1: 使用负向前瞻断言，排除包含*的邮箱
# 这个正则表达式会匹配标准邮箱格式，但不匹配包含*的邮箱
email_regex_no_asterisk = r'^(?!.*\*)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

# 方法2: 更严格的版本，确保用户名和域名部分都不包含*
email_regex_strict = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

def is_valid_email_no_asterisk(email):
    """
    检查邮箱是否有效且不包含星号
    
    Args:
        email: 待检查的邮箱地址
        
    Returns:
        bool: 如果邮箱有效且不包含*，返回True，否则返回False
    """
    # 先检查是否包含*
    if '*' in email:
        return False
    
    # 再检查是否符合邮箱格式
    pattern = re.compile(email_regex_strict)
    return bool(pattern.match(email))

def find_emails_no_asterisk(text):
    """
    从文本中提取所有不包含*的邮箱地址
    
    Args:
        text: 待搜索的文本
        
    Returns:
        list: 匹配到的邮箱地址列表
    """
    # 先匹配所有可能的邮箱
    email_pattern = r'\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b'
    emails = re.findall(email_pattern, text)
    
    # 过滤掉包含*的邮箱
    return [email for email in emails if '*' not in email]

# 测试示例
if __name__ == '__main__':
    test_emails = [
        'user@example.com',      # 有效
        'test.email@domain.cn',  # 有效
        'user*@example.com',     # 无效（包含*）
        'user@ex*ample.com',     # 无效（包含*）
        'user@example.com*',     # 无效（包含*）
        'user.name+tag@example.co.uk',  # 有效
        'invalid.email',         # 无效（不是邮箱格式）
        'user@domain',           # 无效（缺少顶级域名）
    ]
    
    print("=" * 60)
    print("邮箱验证测试（排除带*的邮箱）")
    print("=" * 60)
    
    for email in test_emails:
        result = is_valid_email_no_asterisk(email)
        status = "✓ 有效" if result else "✗ 无效"
        print(f"{email:40} -> {status}")
    
    print("\n" + "=" * 60)
    print("从文本中提取邮箱测试")
    print("=" * 60)
    
    test_text = """
    联系邮箱：admin@example.com 或 support@test.org
    无效邮箱：user*@example.com 和 user@ex*ample.com
    其他邮箱：info@company.cn, sales@business.net
    """
    
    found_emails = find_emails_no_asterisk(test_text)
    print(f"找到的有效邮箱（不含*）: {found_emails}")
