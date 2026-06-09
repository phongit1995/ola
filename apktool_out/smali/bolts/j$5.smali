.class final Lbolts/j$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lbolts/j;->d(Lbolts/k;Lbolts/h;Lbolts/j;Ljava/util/concurrent/Executor;Lbolts/e;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Lbolts/e;

.field final synthetic b:Lbolts/k;

.field final synthetic c:Lbolts/h;

.field final synthetic d:Lbolts/j;


# direct methods
.method constructor <init>(Lbolts/e;Lbolts/k;Lbolts/h;Lbolts/j;)V
    .locals 0

    iput-object p1, p0, Lbolts/j$5;->a:Lbolts/e;

    iput-object p2, p0, Lbolts/j$5;->b:Lbolts/k;

    iput-object p3, p0, Lbolts/j$5;->c:Lbolts/h;

    iput-object p4, p0, Lbolts/j$5;->d:Lbolts/j;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lbolts/j$5;->a:Lbolts/e;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lbolts/j$5;->a:Lbolts/e;

    invoke-virtual {v0}, Lbolts/e;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lbolts/j$5;->b:Lbolts/k;

    invoke-virtual {v0}, Lbolts/k;->c()V

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lbolts/j$5;->c:Lbolts/h;

    iget-object v1, p0, Lbolts/j$5;->d:Lbolts/j;

    invoke-interface {v0, v1}, Lbolts/h;->then(Lbolts/j;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lbolts/j;

    if-nez v0, :cond_1

    iget-object v0, p0, Lbolts/j$5;->b:Lbolts/k;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lbolts/k;->b(Ljava/lang/Object;)V

    return-void

    :cond_1
    new-instance v1, Lbolts/j$5$1;

    invoke-direct {v1, p0}, Lbolts/j$5$1;-><init>(Lbolts/j$5;)V

    invoke-virtual {v0, v1}, Lbolts/j;->a(Lbolts/h;)Lbolts/j;
    :try_end_0
    .catch Ljava/util/concurrent/CancellationException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lbolts/j$5;->b:Lbolts/k;

    invoke-virtual {v1, v0}, Lbolts/k;->b(Ljava/lang/Exception;)V

    return-void

    :catch_1
    iget-object v0, p0, Lbolts/j$5;->b:Lbolts/k;

    invoke-virtual {v0}, Lbolts/k;->c()V

    return-void
.end method
