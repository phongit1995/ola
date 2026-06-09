.class Lchat/ola/vn/view/g$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/g;->A(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/i;

.field final synthetic b:Lchat/ola/vn/view/g;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/g;Lchat/ola/vn/entity/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/g$2;->b:Lchat/ola/vn/view/g;

    iput-object p2, p0, Lchat/ola/vn/view/g$2;->a:Lchat/ola/vn/entity/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/g$2;->b:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->i(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/g$2;->a:Lchat/ola/vn/entity/i;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/g$c;->a(Lchat/ola/vn/entity/i;)V

    iget-object v0, p0, Lchat/ola/vn/view/g$2;->b:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->i(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/view/g$c;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/view/g$2;->b:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->j(Lchat/ola/vn/view/g;)Lit/sephiroth/android/library/widget/HListView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/HListView;->c(I)V

    return-void
.end method
