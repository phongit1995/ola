.class Lchat/ola/vn/m/s$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/m/s;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/s;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/s;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/s$1;->a:Lchat/ola/vn/m/s;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/s$1;->a:Lchat/ola/vn/m/s;

    invoke-static {v0}, Lchat/ola/vn/m/s;->a(Lchat/ola/vn/m/s;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getChildCount()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/m/s$1;->a:Lchat/ola/vn/m/s;

    invoke-static {v1}, Lchat/ola/vn/m/s;->a(Lchat/ola/vn/m/s;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object v1

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v0, v2

    if-lt v1, v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/s$1;->a:Lchat/ola/vn/m/s;

    invoke-static {v0}, Lchat/ola/vn/m/s;->a(Lchat/ola/vn/m/s;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object v0

    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1, v2}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(IZ)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/s$1;->a:Lchat/ola/vn/m/s;

    invoke-static {v0}, Lchat/ola/vn/m/s;->a(Lchat/ola/vn/m/s;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object v0

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/m/s$1;->a:Lchat/ola/vn/m/s;

    invoke-static {v0}, Lchat/ola/vn/m/s;->a(Lchat/ola/vn/m/s;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object v0

    const-wide/16 v1, 0x1388

    invoke-virtual {v0, p0, v1, v2}, Lcom/mg/ola/common/widget/OlaViewPager;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
