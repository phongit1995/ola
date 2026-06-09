.class Lchat/ola/vn/me/OlaMeCommentActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaMeCommentActivity;->B()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaMeCommentActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaMeCommentActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity$1;->a:Lchat/ola/vn/me/OlaMeCommentActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRefresh()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity$1;->a:Lchat/ola/vn/me/OlaMeCommentActivity;

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeCommentActivity$1;->a:Lchat/ola/vn/me/OlaMeCommentActivity;

    invoke-static {v1}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Lchat/ola/vn/me/OlaMeCommentActivity;)J

    move-result-wide v1

    const-wide/16 v3, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Lchat/ola/vn/me/OlaMeCommentActivity;JJ)V

    return-void
.end method
