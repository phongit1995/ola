.class Lchat/ola/vn/view/g$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/g;->B(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/view/g;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/g;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/g$3;->b:Lchat/ola/vn/view/g;

    iput-object p2, p0, Lchat/ola/vn/view/g$3;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/g$3;->b:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->i(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/g$3;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/g$c;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/view/g$3;->b:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->i(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/view/g$c;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/view/g$3;->b:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->j(Lchat/ola/vn/view/g;)Lit/sephiroth/android/library/widget/HListView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/HListView;->c(I)V

    return-void
.end method
