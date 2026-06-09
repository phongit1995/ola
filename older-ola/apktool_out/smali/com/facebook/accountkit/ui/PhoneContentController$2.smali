.class Lcom/facebook/accountkit/ui/PhoneContentController$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/PhoneContentController;->setTopFragment(Lcom/facebook/accountkit/ui/ContentFragment;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/PhoneContentController;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/PhoneContentController;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPhoneNumberChanged()V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/PhoneContentController;->access$1000(Lcom/facebook/accountkit/ui/PhoneContentController;)V

    return-void
.end method
