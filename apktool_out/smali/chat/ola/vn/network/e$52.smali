.class Lchat/ola/vn/network/e$52;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->c(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$52;->c:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$52;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$52;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$52;->a:Ljava/lang/String;

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/network/e$52;->b:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/network/e$52;->a:Ljava/lang/String;

    invoke-static {v1, v2}, Lchat/ola/vn/message/e;->a(Ljava/lang/String;Ljava/lang/String;)Lchat/ola/vn/message/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V

    invoke-static {v0, v1}, Lchat/ola/vn/util/c/b;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
