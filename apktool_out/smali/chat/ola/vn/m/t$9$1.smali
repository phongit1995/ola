.class Lchat/ola/vn/m/t$9$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/t$9;->a(Ljava/lang/String;Landroid/widget/EditText;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/widget/EditText;

.field final synthetic b:Lchat/ola/vn/m/t$9;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/t$9;Landroid/widget/EditText;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/t$9$1;->b:Lchat/ola/vn/m/t$9;

    iput-object p2, p0, Lchat/ola/vn/m/t$9$1;->a:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/m/t$9$1;->b:Lchat/ola/vn/m/t$9;

    iget-object v0, v0, Lchat/ola/vn/m/t$9;->g:Lchat/ola/vn/m/t;

    iget-object v1, p0, Lchat/ola/vn/m/t$9$1;->b:Lchat/ola/vn/m/t$9;

    iget-object v1, v1, Lchat/ola/vn/m/t$9;->g:Lchat/ola/vn/m/t;

    iget-object v1, v1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->B()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/m/t;->a(Lchat/ola/vn/m/t;JJ)V

    iget-object v0, p0, Lchat/ola/vn/m/t$9$1;->b:Lchat/ola/vn/m/t$9;

    iget-object v0, v0, Lchat/ola/vn/m/t$9;->g:Lchat/ola/vn/m/t;

    invoke-virtual {v0}, Lchat/ola/vn/m/t;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/t$9$1;->a:Landroid/widget/EditText;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    return-void
.end method
