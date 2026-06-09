.class Lchat/ola/vn/m/w$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/w$2;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/e;

.field final synthetic b:Lchat/ola/vn/m/w$2;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/w$2;Lchat/ola/vn/entity/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/w$2$1;->b:Lchat/ola/vn/m/w$2;

    iput-object p2, p0, Lchat/ola/vn/m/w$2$1;->a:Lchat/ola/vn/entity/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/w$2$1;->b:Lchat/ola/vn/m/w$2;

    iget-object v0, v0, Lchat/ola/vn/m/w$2;->a:Lchat/ola/vn/m/w;

    iget-object v1, p0, Lchat/ola/vn/m/w$2$1;->a:Lchat/ola/vn/entity/e;

    iput-object v1, v0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    iget-object v0, p0, Lchat/ola/vn/m/w$2$1;->b:Lchat/ola/vn/m/w$2;

    iget-object v0, v0, Lchat/ola/vn/m/w$2;->a:Lchat/ola/vn/m/w;

    iget-object v0, v0, Lchat/ola/vn/m/w;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/entity/e;->b(II)V

    iget-object v0, p0, Lchat/ola/vn/m/w$2$1;->b:Lchat/ola/vn/m/w$2;

    iget-object v0, v0, Lchat/ola/vn/m/w$2;->a:Lchat/ola/vn/m/w;

    invoke-virtual {v0}, Lchat/ola/vn/m/w;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
