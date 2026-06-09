.class Lchat/ola/vn/entity/e$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entity/e;->b(Landroid/widget/ListView;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/widget/ListView;

.field final synthetic b:Lchat/ola/vn/entity/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/entity/e;Landroid/widget/ListView;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e$1;->b:Lchat/ola/vn/entity/e;

    iput-object p2, p0, Lchat/ola/vn/entity/e$1;->a:Landroid/widget/ListView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/entity/e$1;->b:Lchat/ola/vn/entity/e;

    invoke-static {v0}, Lchat/ola/vn/entity/e;->i(Lchat/ola/vn/entity/e;)I

    move-result v0

    if-gez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/e$1;->b:Lchat/ola/vn/entity/e;

    invoke-static {v0}, Lchat/ola/vn/entity/e;->j(Lchat/ola/vn/entity/e;)I

    move-result v0

    if-ltz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e$1;->a:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/entity/e$1;->b:Lchat/ola/vn/entity/e;

    invoke-static {v1}, Lchat/ola/vn/entity/e;->i(Lchat/ola/vn/entity/e;)I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/entity/e$1;->b:Lchat/ola/vn/entity/e;

    invoke-static {v2}, Lchat/ola/vn/entity/e;->j(Lchat/ola/vn/entity/e;)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/ListView;->setSelectionFromTop(II)V

    :cond_1
    return-void
.end method
