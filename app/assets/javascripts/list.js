console.log('%c /list.js loaded..', 'font-size:20px; background:black; color: #0f2')

tasks = []

class Task {
    constructor(id, title, completed) {
        this.title = title
        this.completed = completed
        this.id = id
    }

    toggleComplete(){
        fetch(`/tasks/${this.id}/toggle`,{method:"POST"})
        .then(res=>res.json())
        .then(res => {
            this.completed = res.completed
            refresh()
        })
        
    }

    render() {
        // Create the elements that comprise the list variable
        let ls = document.createElement('ls')
        let title = document.createElement('div')
        let button = document.createElement('button')
        let icon = document.createElement('i')

        //Apply appropriate styles to the new elements
        ls.className = "list-group-item d-flex  align-items-start listDo"
        title.className = "ml-3"
        button.className = this.completed ? "btn done toggle" : "btn not-done toggle"
        icon.className = this.completed ? "fas fa-check" : "fas fa-times"

        //add an event listener to the button to toggle the class's completion state
        //binding this so we can access the task instance method inside of the callback
        button.addEventListener('click',this.toggleComplete.bind(this))

        //wrap the new elements into each other
        button.prepend(icon)
        title.innerHTML = this.title
        ls.prepend(title)
        ls.prepend(button)

        //return new object
        return ls
    }
}

refresh = () => {
    ul = document.getElementById('list-body')
    ul.innerHTML = ''
    
    tasks.forEach((task) => {
        
        ul.appendChild(task.render())
    })
}

getTasks = () => {
    fetch(`/lists/${document.getElementById('list-id').innerHTML}.json`)
        .then((x) => x.json())
        .then((list) => {
            tasks = list.tasks.map((task)=>new Task(task.id, task.title, task.completed))
            refresh()
            return tasks
        })
}


getTasks()