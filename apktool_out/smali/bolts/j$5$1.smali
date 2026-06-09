.class Lbolts/j$5$1;
.super Ljava/lang/Object;

# interfaces
.implements Lbolts/h;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lbolts/j$5;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lbolts/h<",
        "TTContinuationResult;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lbolts/j$5;


# direct methods
.method constructor <init>(Lbolts/j$5;)V
    .locals 0

    iput-object p1, p0, Lbolts/j$5$1;->a:Lbolts/j$5;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lbolts/j;)Ljava/lang/Void;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lbolts/j<",
            "TTContinuationResult;>;)",
            "Ljava/lang/Void;"
        }
    .end annotation

    iget-object v0, p0, Lbolts/j$5$1;->a:Lbolts/j$5;

    iget-object v0, v0, Lbolts/j$5;->a:Lbolts/e;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lbolts/j$5$1;->a:Lbolts/j$5;

    iget-object v0, v0, Lbolts/j$5;->a:Lbolts/e;

    invoke-virtual {v0}, Lbolts/e;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lbolts/j$5$1;->a:Lbolts/j$5;

    iget-object p1, p1, Lbolts/j$5;->b:Lbolts/k;

    invoke-virtual {p1}, Lbolts/k;->c()V

    return-object v1

    :cond_0
    invoke-virtual {p1}, Lbolts/j;->d()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object p1, p0, Lbolts/j$5$1;->a:Lbolts/j$5;

    iget-object p1, p1, Lbolts/j$5;->b:Lbolts/k;

    invoke-virtual {p1}, Lbolts/k;->c()V

    return-object v1

    :cond_1
    invoke-virtual {p1}, Lbolts/j;->e()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lbolts/j$5$1;->a:Lbolts/j$5;

    iget-object v0, v0, Lbolts/j$5;->b:Lbolts/k;

    invoke-virtual {p1}, Lbolts/j;->g()Ljava/lang/Exception;

    move-result-object p1

    invoke-virtual {v0, p1}, Lbolts/k;->b(Ljava/lang/Exception;)V

    return-object v1

    :cond_2
    iget-object v0, p0, Lbolts/j$5$1;->a:Lbolts/j$5;

    iget-object v0, v0, Lbolts/j$5;->b:Lbolts/k;

    invoke-virtual {p1}, Lbolts/j;->f()Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v0, p1}, Lbolts/k;->b(Ljava/lang/Object;)V

    return-object v1
.end method

.method public synthetic then(Lbolts/j;)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lbolts/j$5$1;->a(Lbolts/j;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method
