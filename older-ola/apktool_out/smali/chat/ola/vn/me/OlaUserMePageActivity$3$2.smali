.class Lchat/ola/vn/me/OlaUserMePageActivity$3$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity$3;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaUserMePageActivity$3;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaUserMePageActivity$3;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3$2;->a:Lchat/ola/vn/me/OlaUserMePageActivity$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 7

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->f(S)V

    const/4 p2, 0x1

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v1

    sput-object v1, Lchat/ola/vn/c/x;->e:Ljava/lang/Short;

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3$2;->a:Lchat/ola/vn/me/OlaUserMePageActivity$3;

    iget-object v1, v1, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3$2;->a:Lchat/ola/vn/me/OlaUserMePageActivity$3;

    iget-object v2, v2, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const v3, 0x7f0f055f

    new-array p2, p2, [Ljava/lang/Object;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3$2;->a:Lchat/ola/vn/me/OlaUserMePageActivity$3;

    iget-object v5, v5, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const v6, 0x7f0f0559

    invoke-virtual {v5, v6}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "\""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, p2, v0

    invoke-virtual {v2, v3, p2}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-static {v1, p2}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
