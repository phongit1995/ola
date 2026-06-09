.class Lchat/ola/vn/m/j$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->e(Lchat/ola/vn/entity/t;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$3;->b:Lchat/ola/vn/m/j;

    iput p2, p0, Lchat/ola/vn/m/j$3;->a:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/m/j$3;->b:Lchat/ola/vn/m/j;

    invoke-static {v0}, Lchat/ola/vn/m/j;->d(Lchat/ola/vn/m/j;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object v0

    iget v1, p0, Lchat/ola/vn/m/j$3;->a:I

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(IZ)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/j$3;->b:Lchat/ola/vn/m/j;

    iget-object v1, p0, Lchat/ola/vn/m/j$3;->b:Lchat/ola/vn/m/j;

    invoke-static {v1}, Lchat/ola/vn/m/j;->e(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/j$a;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/m/j$3;->b:Lchat/ola/vn/m/j;

    invoke-static {v2}, Lchat/ola/vn/m/j;->d(Lchat/ola/vn/m/j;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object v2

    iget v3, p0, Lchat/ola/vn/m/j$3;->a:I

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/m/j$a;->a(Landroid/support/v4/view/ViewPager;I)Landroid/support/v4/app/Fragment;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/m/c;

    invoke-static {v0, v1}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/m/j;Lchat/ola/vn/m/c;)Lchat/ola/vn/m/c;

    iget-object v0, p0, Lchat/ola/vn/m/j$3;->b:Lchat/ola/vn/m/j;

    invoke-static {v0}, Lchat/ola/vn/m/j;->c(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/m/c;->d()V

    iget-object v0, p0, Lchat/ola/vn/m/j$3;->b:Lchat/ola/vn/m/j;

    invoke-virtual {v0}, Lchat/ola/vn/m/j;->d()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
