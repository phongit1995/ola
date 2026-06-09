.class Lchat/ola/vn/network/e$37;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->k(Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:S

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$37;->c:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$37;->a:Ljava/lang/String;

    iput-short p3, p0, Lchat/ola/vn/network/e$37;->b:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$37;->a:Ljava/lang/String;

    iget-short v2, p0, Lchat/ola/vn/network/e$37;->b:S

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->C()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/e$37;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$37;->a:Ljava/lang/String;

    iget-short v3, p0, Lchat/ola/vn/network/e$37;->b:S

    invoke-interface {v1, v2, v3}, Lchat/ola/vn/network/f;->g(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method
