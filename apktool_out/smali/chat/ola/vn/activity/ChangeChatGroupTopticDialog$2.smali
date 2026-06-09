.class Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$2;->a:Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$2;->a:Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;

    invoke-static {v0}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->a(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$2;->a:Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;

    invoke-static {p1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->b(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)Lchat/ola/vn/b/ae;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/ae;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog$2;->a:Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;

    invoke-static {p1}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->c(Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;)Lchat/ola/vn/view/OlaGalleryView;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaGalleryView;->a()V

    :cond_0
    return-void
.end method
