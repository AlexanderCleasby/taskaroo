console.log('%c /list.js loaded..', 'font-size:20px; background:black; color: #0f2')

tasks = []

class Task {
    constructor(id, title, completed) {
        this.title = title
        this.completed = completed
        this.id = id
    }

    toggleComplete() {
        fetch(`/tasks/${this.id}/toggle`, {
                method: "POST"
            })
            .then(res => res.json())
            .then(res => {
                this.completed = res.completed
            })

    }

    render() {
        // Create the elements that comprise the list variable
        let li = document.createElement('li')
        let title = document.createElement('div')
        let button = document.createElement('button')
        let icon = document.createElement('i')

        //Apply appropriate styles to the new elements
        //TODO: we can use scss to consolidate this.
        li.className = "list-group-item d-flex  align-items-start listDo"
        title.className = "ml-3"
        button.className = this.completed ? "btn done toggle" : "btn not-done"
        icon.className = this.completed ? "fas fa-check" : "fas fa-times"

        //add an event listener to the button to toggle the class's completion state
        //binding this so we can access the task instance method inside of the callback
        button.addEventListener('click', this.toggleComplete.bind(this))
        button.addEventListener("mouseenter",(e)=>
            {e.target.className=!this.completed ? "btn done" : "btn not-done"
            icon.className = !this.completed ? "fas fa-check" : "fas fa-times"})

        button.addEventListener("mouseleave",(e)=>{
            button.className = this.completed ? "btn done " : "btn not-done toggle"
            icon.className = this.completed ? "fas fa-check" : "fas fa-times"
        })

        //wrap the new elements into each other
        button.prepend(icon)
        title.innerHTML = this.title
        li.prepend(title)
        li.prepend(button)

        //return new object
        return li
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
            tasks = list.tasks.map((task) => new Task(task.id, task.title, task.completed))
            refresh()
            return tasks
        })
}

userListModalShow = () => {
    let modal = document.getElementById("add-user-list-modal")
    modal.style.display = "block";
    modal.className = "modal fade show";
    document.getElementById("add-user-list-modal-close").addEventListener('click',userListModalHide)
}

userListModalHide = ()=>{
    document.getElementById("add-user-list-modal").style.display = "none";
    document.getElementById("add-user-list-modal").className = "modal fade";
}

document.addEventListener("turbolinks:load", () => {
    if (document.getElementById('new_task')) {
        document.getElementById('new_task').addEventListener('submit', (e) => {
            e.preventDefault()
            fetch(e.target.action, {
                    method: 'POST',
                    body: new FormData(e.target)
                })
                .then((res) => res.json())
                .then((res) => {
                    getTasks()
                    document.getElementById('task_title').value = ''

                })

        })
    }

    if (document.getElementById('list-id')) {
        getTasks()
    }

    if (document.getElementById("add-user-list-modal-show")){
        document.getElementById("add-user-list-modal-show").addEventListener('click',userListModalShow)
    }
})