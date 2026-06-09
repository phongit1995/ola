.class Lchat/ola/vn/network/e$117;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Ljava/lang/String;

.field final synthetic f:S

.field final synthetic g:Ljava/lang/String;

.field final synthetic h:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$117;->h:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$117;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$117;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/network/e$117;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/network/e$117;->d:Ljava/lang/String;

    iput-object p6, p0, Lchat/ola/vn/network/e$117;->e:Ljava/lang/String;

    iput-short p7, p0, Lchat/ola/vn/network/e$117;->f:S

    iput-object p8, p0, Lchat/ola/vn/network/e$117;->g:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$117;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/network/e$117;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x2

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->a:Ljava/lang/String;

    invoke-virtual {v0, v4, v3, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    iput-boolean v1, v0, Lchat/ola/vn/message/f;->B:Z

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->c:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->d:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->e:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->g(Ljava/lang/String;)V

    :goto_0
    sget-object v4, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v4, v0}, Lchat/ola/vn/message/g;->k(Lchat/ola/vn/message/f;)V

    goto :goto_2

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->b:Ljava/lang/String;

    invoke-virtual {v0, v4, v3}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->a:Ljava/lang/String;

    invoke-virtual {v0, v4, v3, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    goto :goto_1

    :cond_1
    sget-object v4, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v5, p0, Lchat/ola/vn/network/e$117;->a:Ljava/lang/String;

    invoke-static {v5, v3}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5, v0}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;Lchat/ola/vn/message/f;)V

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->a:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->a(Ljava/lang/String;)V

    :goto_1
    iput-boolean v1, v0, Lchat/ola/vn/message/f;->B:Z

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->c:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->d:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    iget-object v4, p0, Lchat/ola/vn/network/e$117;->e:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->g(Ljava/lang/String;)V

    goto :goto_0

    :goto_2
    iget-short v0, p0, Lchat/ola/vn/network/e$117;->f:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_2

    const/4 v4, 0x5

    new-array v4, v4, [Ljava/lang/Object;

    iget-object v5, p0, Lchat/ola/vn/network/e$117;->g:Ljava/lang/String;

    aput-object v5, v4, v1

    iget-object v1, p0, Lchat/ola/vn/network/e$117;->a:Ljava/lang/String;

    aput-object v1, v4, v2

    iget-object v1, p0, Lchat/ola/vn/network/e$117;->e:Ljava/lang/String;

    aput-object v1, v4, v3

    const/4 v1, 0x3

    iget-object v2, p0, Lchat/ola/vn/network/e$117;->c:Ljava/lang/String;

    aput-object v2, v4, v1

    const/4 v1, 0x4

    iget-object v2, p0, Lchat/ola/vn/network/e$117;->d:Ljava/lang/String;

    aput-object v2, v4, v1

    invoke-virtual {v0, v4}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
