.class Lchat/ola/vn/m/g$5$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/g$5;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/e;

.field final synthetic b:Lchat/ola/vn/m/g$5;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/g$5;Lchat/ola/vn/entity/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/g$5$1;->b:Lchat/ola/vn/m/g$5;

    iput-object p2, p0, Lchat/ola/vn/m/g$5$1;->a:Lchat/ola/vn/entity/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/g$5$1;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->m()Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/m/g;->c(Ljava/util/List;)Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/m/g$5$1;->b:Lchat/ola/vn/m/g$5;

    iget-object v0, v0, Lchat/ola/vn/m/g$5;->a:Lchat/ola/vn/m/g;

    invoke-virtual {v0}, Lchat/ola/vn/m/g;->h()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
