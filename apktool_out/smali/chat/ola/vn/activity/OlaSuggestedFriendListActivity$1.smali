.class Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a_(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x45

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    const/4 p3, 0x0

    invoke-static {p2, p3}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;Z)Z

    const/16 p2, 0x22

    if-ne p1, p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;Ljava/lang/String;)Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 5

    const/4 v0, 0x0

    :try_start_0
    aget-object v1, p1, v0

    check-cast v1, [Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    const/4 v3, 0x1

    aget-object p1, p1, v3

    check-cast p1, Ljava/lang/String;

    invoke-static {v2, p1}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;Z)Z

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    invoke-static {p1, v3}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;Z)Z

    :goto_0
    array-length p1, v1

    const/4 v2, 0x0

    :goto_1
    if-ge v2, p1, :cond_3

    aget-object v3, v1, v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    const-string v4, "#"

    invoke-virtual {v3, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_2

    invoke-static {v3}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v4, v3, v0}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v4

    if-eqz v4, :cond_1

    goto :goto_2

    :cond_1
    new-instance v4, Lchat/ola/vn/message/f;

    invoke-direct {v4, v3, v0}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    iget-object v3, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    invoke-static {v3}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->b(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_2
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_3
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->c(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)Lchat/ola/vn/b/ac;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->b(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ac;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;->a:Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->c(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)Lchat/ola/vn/b/ac;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/ac;->notifyDataSetChanged()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method
