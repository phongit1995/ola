.class Lchat/ola/vn/view/i$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/i$1;->a(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/i$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/i$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/i$1$1;->a:Lchat/ola/vn/view/i$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/i$1$1;->a:Lchat/ola/vn/view/i$1;

    iget-object v0, v0, Lchat/ola/vn/view/i$1;->a:Lchat/ola/vn/view/i;

    invoke-static {v0}, Lchat/ola/vn/view/i;->c(Lchat/ola/vn/view/i;)Landroid/support/v4/view/ViewPager;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1, v1}, Landroid/support/v4/view/ViewPager;->setCurrentItem(IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
