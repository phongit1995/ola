.class Lbolts/j$3;
.super Ljava/lang/Object;

# interfaces
.implements Lbolts/h;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lbolts/j;->c(Lbolts/h;Ljava/util/concurrent/Executor;Lbolts/e;)Lbolts/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lbolts/h<",
        "TTResult;",
        "Lbolts/j<",
        "TTContinuationResult;>;>;"
    }
.end annotation


# instance fields
.field final synthetic a:Lbolts/e;

.field final synthetic b:Lbolts/h;

.field final synthetic c:Lbolts/j;


# direct methods
.method constructor <init>(Lbolts/j;Lbolts/e;Lbolts/h;)V
    .locals 0

    iput-object p1, p0, Lbolts/j$3;->c:Lbolts/j;

    iput-object p2, p0, Lbolts/j$3;->a:Lbolts/e;

    iput-object p3, p0, Lbolts/j$3;->b:Lbolts/h;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lbolts/j;)Lbolts/j;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lbolts/j<",
            "TTResult;>;)",
            "Lbolts/j<",
            "TTContinuationResult;>;"
        }
    .end annotation

    iget-object v0, p0, Lbolts/j$3;->a:Lbolts/e;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lbolts/j$3;->a:Lbolts/e;

    invoke-virtual {v0}, Lbolts/e;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lbolts/j;->h()Lbolts/j;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-virtual {p1}, Lbolts/j;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lbolts/j;->g()Ljava/lang/Exception;

    move-result-object p1

    invoke-static {p1}, Lbolts/j;->a(Ljava/lang/Exception;)Lbolts/j;

    move-result-object p1

    return-object p1

    :cond_1
    invoke-virtual {p1}, Lbolts/j;->d()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {}, Lbolts/j;->h()Lbolts/j;

    move-result-object p1

    return-object p1

    :cond_2
    iget-object v0, p0, Lbolts/j$3;->b:Lbolts/h;

    invoke-virtual {p1, v0}, Lbolts/j;->a(Lbolts/h;)Lbolts/j;

    move-result-object p1

    return-object p1
.end method

.method public synthetic then(Lbolts/j;)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lbolts/j$3;->a(Lbolts/j;)Lbolts/j;

    move-result-object p1

    return-object p1
.end method
