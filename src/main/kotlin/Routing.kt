package com.example

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.serialization.Serializable

@Serializable
data class Task(
    val id: Int,
    val content: String,
    val isDone: Boolean
)

@Serializable
data class TaskRequest(
    val content: String,
    val isDone: Boolean
)

object TaskRepository {
    private val tasks = mutableListOf(
        Task(id = 1, content = "Learn Ktor", isDone = true),
        Task(id = 2, content = "Build a REST API", isDone = false),
        Task(id = 3, content = "Write Unit Tests", isDone = false)
    )
    private var nextId = 4

    fun getAll(): List<Task> = tasks.toList()

    fun getById(id: Int): Task? = tasks.find { it.id == id }

    fun add(taskRequest: TaskRequest): Task {
        val task = Task(
            id = nextId++,
            content = taskRequest.content,
            isDone = taskRequest.isDone
        )
        tasks.add(task)
        return task
    }

    fun update(id: Int, updatedTask: Task): Task? {
        val index = tasks.indexOfFirst { it.id == id }
        return if (index != -1) {
            tasks[index] = updatedTask
            updatedTask
        } else null
    }

    fun delete(id: Int): Boolean {
        val index = tasks.indexOfFirst { it.id == id }
        return if (index != -1) {
            tasks.removeAt(index)
            true
        } else false
    }
}

fun Application.configureRouting() {
    routing {
        route("/tasks") {
            // GET /tasks - Return all tasks
            get {
                val tasks = TaskRepository.getAll()
                call.respond(HttpStatusCode.OK, tasks)
            }

            // POST /tasks - Create a new task
            post {
                try {
                    val taskRequest = call.receive<TaskRequest>()
                    val newTask = TaskRepository.add(taskRequest)
                    call.respond(HttpStatusCode.Created, newTask)
                } catch (e: Exception) {
                    call.respond(HttpStatusCode.BadRequest, "Invalid request body")
                }
            }

            // GET /tasks/{id} - Get a specific task by ID
            get("/{id}") {
                val id = call.parameters["id"]?.toIntOrNull()
                if (id == null) {
                    call.respond(HttpStatusCode.BadRequest, "Invalid ID format")
                    return@get
                }

                val task = TaskRepository.getById(id)
                if (task != null) {
                    call.respond(HttpStatusCode.OK, task)
                } else {
                    call.respond(HttpStatusCode.NotFound, "Task not found")
                }
            }

            // PUT /tasks/{id} - Update a specific task
            put("/{id}") {
                val id = call.parameters["id"]?.toIntOrNull()
                if (id == null) {
                    call.respond(HttpStatusCode.BadRequest, "Invalid ID format")
                    return@put
                }

                try {
                    val taskRequest = call.receive<TaskRequest>()
                    val updatedTask = Task(id, taskRequest.content, taskRequest.isDone)
                    val result = TaskRepository.update(id, updatedTask)
                    
                    if (result != null) {
                        call.respond(HttpStatusCode.OK, result)
                    } else {
                        call.respond(HttpStatusCode.NotFound, "Task not found")
                    }
                } catch (e: Exception) {
                    call.respond(HttpStatusCode.BadRequest, "Invalid request body")
                }
            }

            // DELETE /tasks/{id} - Delete a specific task
            delete("/{id}") {
                val id = call.parameters["id"]?.toIntOrNull()
                if (id == null) {
                    call.respond(HttpStatusCode.BadRequest, "Invalid ID format")
                    return@delete
                }

                val deleted = TaskRepository.delete(id)
                if (deleted) {
                    call.respond(HttpStatusCode.NoContent)
                } else {
                    call.respond(HttpStatusCode.NotFound, "Task not found")
                }
            }
        }

        // Keep the original root endpoint
        get("/") {
            call.respondText("Hello World!")
        }
    }
}
