.class Lchat/ola/vn/activity/ContactFinderActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/ContactFinderActivity;->a(Lchat/ola/vn/message/f;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/message/f;

.field final synthetic c:Lchat/ola/vn/activity/ContactFinderActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/ContactFinderActivity;Ljava/util/List;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/ContactFinderActivity$3;->c:Lchat/ola/vn/activity/ContactFinderActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/ContactFinderActivity$3;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/activity/ContactFinderActivity$3;->b:Lchat/ola/vn/message/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/ContactFinderActivity$3;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/ContactFinderActivity$3;->c:Lchat/ola/vn/activity/ContactFinderActivity;

    const p3, 0x7f0f0465

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/ContactFinderActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/ContactFinderActivity$3;->c:Lchat/ola/vn/activity/ContactFinderActivity;

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p3, p0, Lchat/ola/vn/activity/ContactFinderActivity$3;->b:Lchat/ola/vn/message/f;

    invoke-static {p1, p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Lchat/ola/vn/message/f;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ContactFinderActivity$3;->c:Lchat/ola/vn/activity/ContactFinderActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/ContactFinderActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
