.class Lchat/ola/vn/network/e$53;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->c(Ljava/lang/String;Lchat/ola/vn/message/d;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/message/d;

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$53;->c:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$53;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$53;->b:Lchat/ola/vn/message/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$53;->a:Ljava/lang/String;

    const/4 v2, 0x1

    const/4 v3, 0x2

    invoke-virtual {v0, v1, v3, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    iget-object v4, p0, Lchat/ola/vn/network/e$53;->b:Lchat/ola/vn/message/d;

    invoke-virtual {v4}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v4

    invoke-static {v1, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/network/e$53;->b:Lchat/ola/vn/message/d;

    invoke-static {v1, v3}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object v1

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/network/e$53;->b:Lchat/ola/vn/message/d;

    invoke-static {v1, v2}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V

    invoke-static {v0, v1}, Lchat/ola/vn/util/c/b;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
