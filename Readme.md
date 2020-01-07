# Hamcrest AutoLayout Matchers

This frameworks contains [Hamcrest](https://github.com/nschum/SwiftHamcrest) matchers to verify auto layout constraints.

Example:

```
func test_height_matcher() {
	// given
	first.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
		
	// expect
	assertThat(first, hasHeight(of: 44))
}
``` 

