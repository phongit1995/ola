.class Lcom/mg/ola/a/a/b/c$e;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Cloneable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/b/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "e"
.end annotation


# instance fields
.field public a:Lcom/mg/ola/a/a/b/a;

.field public b:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/c$c;",
            ">;"
        }
    .end annotation
.end field

.field public c:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/c$c;",
            ">;"
        }
    .end annotation
.end field

.field public d:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/c$e;",
            ">;"
        }
    .end annotation
.end field

.field public e:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/c$e;",
            ">;"
        }
    .end annotation
.end field

.field public f:Z


# direct methods
.method public constructor <init>(Lcom/mg/ola/a/a/b/a;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->c:Ljava/util/ArrayList;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->e:Ljava/util/ArrayList;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/c$e;->f:Z

    iput-object p1, p0, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    return-void
.end method


# virtual methods
.method public a()Lcom/mg/ola/a/a/b/c$e;
    .locals 2

    :try_start_0
    invoke-super {p0}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/c$e;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/a;->g()Lcom/mg/ola/a/a/b/a;

    move-result-object v1

    iput-object v1, v0, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;
    :try_end_0
    .catch Ljava/lang/CloneNotSupportedException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public a(Lcom/mg/ola/a/a/b/c$c;)V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    iget-object v1, p1, Lcom/mg/ola/a/a/b/c$c;->a:Lcom/mg/ola/a/a/b/c$e;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    iget-object v1, p1, Lcom/mg/ola/a/a/b/c$c;->a:Lcom/mg/ola/a/a/b/c$e;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_1
    iget-object p1, p1, Lcom/mg/ola/a/a/b/c$c;->a:Lcom/mg/ola/a/a/b/c$e;

    iget-object v0, p1, Lcom/mg/ola/a/a/b/c$e;->e:Ljava/util/ArrayList;

    if-nez v0, :cond_2

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p1, Lcom/mg/ola/a/a/b/c$e;->e:Ljava/util/ArrayList;

    :cond_2
    iget-object p1, p1, Lcom/mg/ola/a/a/b/c$e;->e:Ljava/util/ArrayList;

    invoke-virtual {p1, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/c$e;->a()Lcom/mg/ola/a/a/b/c$e;

    move-result-object v0

    return-object v0
.end method
