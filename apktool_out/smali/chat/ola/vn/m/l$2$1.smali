.class Lchat/ola/vn/m/l$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/l$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/l$2;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/l$2;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/l$2$1;->a:Lchat/ola/vn/m/l$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/l$2$1;->a:Lchat/ola/vn/m/l$2;

    iget-object v0, v0, Lchat/ola/vn/m/l$2;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->d(Lchat/ola/vn/m/l;)Landroid/widget/ListView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/l$2$1;->a:Lchat/ola/vn/m/l$2;

    iget-object v1, v1, Lchat/ola/vn/m/l$2;->a:Lchat/ola/vn/m/l;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    return-void
.end method
