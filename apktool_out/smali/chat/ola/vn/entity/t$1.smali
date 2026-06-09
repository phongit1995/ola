.class Lchat/ola/vn/entity/t$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entity/t;->b(Landroid/widget/ListView;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/widget/ListView;

.field final synthetic b:Lchat/ola/vn/entity/t;


# direct methods
.method constructor <init>(Lchat/ola/vn/entity/t;Landroid/widget/ListView;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/t$1;->b:Lchat/ola/vn/entity/t;

    iput-object p2, p0, Lchat/ola/vn/entity/t$1;->a:Landroid/widget/ListView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entity/t$1;->b:Lchat/ola/vn/entity/t;

    iget v0, v0, Lchat/ola/vn/entity/t;->t:I

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/t$1;->a:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/entity/t$1;->b:Lchat/ola/vn/entity/t;

    iget v1, v1, Lchat/ola/vn/entity/t;->t:I

    iget-object v2, p0, Lchat/ola/vn/entity/t$1;->b:Lchat/ola/vn/entity/t;

    iget v2, v2, Lchat/ola/vn/entity/t;->s:I

    invoke-virtual {v0, v1, v2}, Landroid/widget/ListView;->setSelectionFromTop(II)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/t$1;->a:Landroid/widget/ListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
