def dump_response(res):
    content = """
id: {}
output_parsed: {}
input_tokens: {}
output_tokens: {}
""".format(
        res.id,
        res.output_parsed,
        res.usage.input_tokens,
        res.usage.output_tokens,
    )
    print(content)
