.class Lchat/ola/vn/m/g$5$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/g$5;->a(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/g$5;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/g$5;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/g$5$2;->a:Lchat/ola/vn/m/g$5;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Lchat/ola/vn/m/g;->c(Ljava/util/List;)Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/m/g$5$2;->a:Lchat/ola/vn/m/g$5;

    iget-object v0, v0, Lchat/ola/vn/m/g$5;->a:Lchat/ola/vn/m/g;

    invoke-virtual {v0}, Lchat/ola/vn/m/g;->h()V

    return-void
.end method
