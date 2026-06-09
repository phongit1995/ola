.class Lcom/mg/ola/a/a/b/l$b;
.super Lcom/mg/ola/a/a/b/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/b/l;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "b"
.end annotation


# instance fields
.field h:Lcom/mg/ola/a/a/b/g;

.field i:I

.field private j:Lcom/mg/ola/a/a/a/b;


# direct methods
.method public varargs constructor <init>(Lcom/mg/ola/a/a/a/c;[I)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/mg/ola/a/a/b/l;-><init>(Lcom/mg/ola/a/a/a/c;Lcom/mg/ola/a/a/b/l$1;)V

    invoke-virtual {p0, p2}, Lcom/mg/ola/a/a/b/l$b;->a([I)V

    instance-of p1, p1, Lcom/mg/ola/a/a/a/b;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/a/a/b/l$b;->b:Lcom/mg/ola/a/a/a/c;

    check-cast p1, Lcom/mg/ola/a/a/a/b;

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l$b;->j:Lcom/mg/ola/a/a/a/b;

    :cond_0
    return-void
.end method

.method public varargs constructor <init>(Ljava/lang/String;[I)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/mg/ola/a/a/b/l;-><init>(Ljava/lang/String;Lcom/mg/ola/a/a/b/l$1;)V

    invoke-virtual {p0, p2}, Lcom/mg/ola/a/a/b/l$b;->a([I)V

    return-void
.end method


# virtual methods
.method public synthetic a()Lcom/mg/ola/a/a/b/l;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/l$b;->e()Lcom/mg/ola/a/a/b/l$b;

    move-result-object v0

    return-object v0
.end method

.method a(F)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l$b;->h:Lcom/mg/ola/a/a/b/g;

    invoke-virtual {v0, p1}, Lcom/mg/ola/a/a/b/g;->b(F)I

    move-result p1

    iput p1, p0, Lcom/mg/ola/a/a/b/l$b;->i:I

    return-void
.end method

.method a(Ljava/lang/Class;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l$b;->b:Lcom/mg/ola/a/a/a/c;

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0, p1}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/Class;)V

    return-void
.end method

.method public varargs a([I)V
    .locals 0

    invoke-super {p0, p1}, Lcom/mg/ola/a/a/b/l;->a([I)V

    iget-object p1, p0, Lcom/mg/ola/a/a/b/l$b;->e:Lcom/mg/ola/a/a/b/i;

    check-cast p1, Lcom/mg/ola/a/a/b/g;

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l$b;->h:Lcom/mg/ola/a/a/b/g;

    return-void
.end method

.method b(Ljava/lang/Object;)V
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l$b;->j:Lcom/mg/ola/a/a/a/b;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l$b;->j:Lcom/mg/ola/a/a/a/b;

    iget v1, p0, Lcom/mg/ola/a/a/b/l$b;->i:I

    invoke-virtual {v0, p1, v1}, Lcom/mg/ola/a/a/a/b;->a(Ljava/lang/Object;I)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/l$b;->b:Lcom/mg/ola/a/a/a/c;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l$b;->b:Lcom/mg/ola/a/a/a/c;

    iget v1, p0, Lcom/mg/ola/a/a/b/l$b;->i:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/mg/ola/a/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)V

    return-void

    :cond_1
    iget-object v0, p0, Lcom/mg/ola/a/a/b/l$b;->c:Ljava/lang/reflect/Method;

    if-eqz v0, :cond_2

    :try_start_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/l$b;->g:[Ljava/lang/Object;

    const/4 v1, 0x0

    iget v2, p0, Lcom/mg/ola/a/a/b/l$b;->i:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v0, v1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l$b;->c:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l$b;->g:[Ljava/lang/Object;

    invoke-virtual {v0, p1, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/l$b;->e()Lcom/mg/ola/a/a/b/l$b;

    move-result-object v0

    return-object v0
.end method

.method d()Ljava/lang/Object;
    .locals 1

    iget v0, p0, Lcom/mg/ola/a/a/b/l$b;->i:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method public e()Lcom/mg/ola/a/a/b/l$b;
    .locals 2

    invoke-super {p0}, Lcom/mg/ola/a/a/b/l;->a()Lcom/mg/ola/a/a/b/l;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/l$b;

    iget-object v1, v0, Lcom/mg/ola/a/a/b/l$b;->e:Lcom/mg/ola/a/a/b/i;

    check-cast v1, Lcom/mg/ola/a/a/b/g;

    iput-object v1, v0, Lcom/mg/ola/a/a/b/l$b;->h:Lcom/mg/ola/a/a/b/g;

    return-object v0
.end method
